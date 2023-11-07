import { Injectable } from '@nestjs/common';
import { MediaRepository } from './media.repository';
import { ConfigService } from '@nestjs/config';
import { S3 } from 'aws-sdk';
import { ObjectId } from 'mongodb';

@Injectable()
export class MediaService {
    private readonly region;
    private readonly accessKeyId;
    private readonly secretAccessKey;
    private readonly publicBucketName;

    constructor(
        private readonly mediaRepository: MediaRepository,
        private readonly configService: ConfigService,
    ) {
        this.region = this.configService.get('AWS_REGION');
        this.accessKeyId = this.configService.get('AWS_ACCESS_KEY_ID');
        this.secretAccessKey = this.configService.get('AWS_SECRET_ACCESS_KEY');
        this.publicBucketName = this.configService.get('AWS_PUBLIC_BUCKET_NAME');
    }

    getLinkMediaKey(media_key) {
        const s3 = this.getS3();
        return s3.getSignedUrl('getObject', {
            Key: media_key,
            Bucket: this.publicBucketName,
            Expires: 60 * 60 * 24 * 365,
        });
    }

    async updateACL(media_id) {
        const media = await this.mediaRepository.findById(media_id);
        const s3 = this.getS3();
        s3.upload(
            {
                Bucket: this.publicBucketName,
                Key: media.key,
                ACL: 'public-read',
            },
            (err, data) => { },
        );
        return (
            s3.endpoint.protocol +
            '//' +
            this.publicBucketName +
            '.' +
            s3.endpoint.hostname +
            '/' +
            media.key
        );
    }

    async upload(file) {
        const objectId = new ObjectId();
        const arr_name = file.originalname.split('.');
        const extension = arr_name.pop();
        const name = arr_name.join('.');
        const key = objectId + '/' + this.slug(name) + '.' + extension;
        const url = await this.uploadS3(file.buffer, key, file.mimetype);
        const cleanUrl = (url as string).split('?')[0];

        const data = {
            _id: objectId,
            name: name,
            file_name: String(file.originalname),
            mime_type: file.mimetype,
            size: file.size,
            key: key,
        };
        await this.mediaRepository.create(data);
        return { url: cleanUrl };
    }


    private async uploadS3(file_buffer, key, content_type) {
        const s3 = this.getS3();
        const params = {
            Bucket: this.publicBucketName,
            Key: key,
            Body: file_buffer,
            ContentType: content_type,
            ACL: 'public-read',
        };
        return new Promise((resolve, reject) => {
            s3.upload(params, (err, data) => {
                if (err) {
                    reject(err.message);
                }
                const url = this.getLinkMediaKey(data.Key);
                resolve(url);
                // resolve(data);
            });
        });
    }

    private getS3() {
        return new S3({
            region: this.region,
            accessKeyId: this.accessKeyId,
            secretAccessKey: this.secretAccessKey,
        });
    }

    private slug(str) {
        str = str.replace(/^\s+|\s+$/g, ''); // trim
        str = str.toLowerCase();


        const from =
            'ÁÄÂÀÃÅČÇĆĎÉĚËÈÊẼĔȆĞÍÌÎÏİŇÑÓÖÒÔÕØŘŔŠŞŤÚŮÜÙÛÝŸŽáäâàãåčçćďéěëèêẽĕȇğíìîïıňñóöòôõøðřŕšşťúůüùûýÿžþÞĐđßÆa·/_,:;';
        const to =
            'AAAAAACCCDEEEEEEEEGIIIIINNOOOOOORRSSTUUUUUYYZaaaaaacccdeeeeeeeegiiiiinnooooooorrsstuuuuuyyzbBDdBAa------';
        for (let i = 0, l = from.length; i < l; i++) {
            str = str.replace(new RegExp(from.charAt(i), 'g'), to.charAt(i));
        }

        str = str
            .replace(/[^a-z0-9 -]/g, '') // remove invalid chars
            .replace(/\s+/g, '-') // collapse whitespace and replace by -
            .replace(/-+/g, '-'); // collapse dashes

        return str;
    }
}