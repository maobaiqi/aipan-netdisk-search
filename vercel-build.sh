#!/bin/bash
# vercel-build.sh

# 1. 构建项目
echo "Step 1: Running npm build..."
npm run build

# 2. 替换 nitro.mjs 中的占位符
echo "Step 2: Replacing placeholders in nitro.mjs..."
sed -i \
    -e 's/admin_user/'"$ADMIN_USER"'/g' \
    -e 's/admin_password/'"$ADMIN_PASSWORD"'/g' \
    -e 's|database_url|'"$DATABASE_URL"'|g' \
    -e 's/jwt_secret/'"$JWT_SECRET"'/g' \
    .output/server/chunks/nitro/nitro.mjs

# 3. 执行数据库迁移（如果使用 Prisma）
echo "Step 3: Running database migrations..."
npx prisma generate
npx prisma migrate deploy

echo "Build completed successfully!"
