import { Injectable, CanActivate, ExecutionContext } from '@nestjs/common';
import { Reflector } from '@nestjs/core';

@Injectable()
export class RoleGuard implements CanActivate {
    constructor(
        private reflector: Reflector,
    ) { }

    canActivate(context: ExecutionContext): boolean {
        const requiredRole = this.reflector.get<string>('role', context.getHandler());

        if (!requiredRole) {
            // If the @Role() decorator is not used, the endpoint is accessible by all roles.
            return true;
        }

        const request = context.switchToHttp().getRequest();
        // console.log(request);


        if (request.user.role !== requiredRole) {
            return false;
        }

        return true; // User has the required role.
    }
}
