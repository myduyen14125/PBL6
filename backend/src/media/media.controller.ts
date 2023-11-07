import { Post, UseInterceptors, UploadedFile, Controller, Get, Body, Query, Put } from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { MediaService } from './media.service';

@Controller('media')
export class MediaController {
    constructor(private readonly mediaService: MediaService) { }

    // get link of private file
    @Get('access')
    async getLinkAccess(@Query('key') key: string) {
        const url = this.mediaService.getLinkMediaKey(key);
        return {
            url: url,
        };
    }

    // upload single file
    @Post('upload')
    @UseInterceptors(FileInterceptor('file'))
    async upload(@UploadedFile() file) {
        return await this.mediaService.upload(file);
    }

    // update permission: public-read
    @Put('update-acl')
    async updateAcl(@Body('media_id') media_id: string) {
        return await this.mediaService.updateACL(media_id);
    }

    // // delet file
    // @Delete('delete')
    // async delete(@Query('media_id') media_id: string) {
    //   await this.mediaService.deleteFileS3(media_id);
    //   return true;
    // }
}