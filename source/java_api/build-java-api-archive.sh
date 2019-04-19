#!/bin/sh
source build/build.conf
JAVA_API_ARCHIVE_NAME="grn2-api-132-for-grn${PRODUCT_VERSION}"

rm -rf $JAVA_API_ARCHIVE_NAME
mkdir -p $JAVA_API_ARCHIVE_NAME/docs

wget --no-check-certificate -O api_manual.zip https://github.dev.cybozu.co.jp/garoon/api_manual/archive/master.zip
rm -rf api_manual api_manual-master
unzip api_manual.zip

cp -f api_manual-master/java_api/doc/pdf/* $JAVA_API_ARCHIVE_NAME/docs
cp -f api_manual-master/java_api/doc/api_change_history.txt $JAVA_API_ARCHIVE_NAME/docs
cp -f api_manual-master/java_api/doc/readme.txt $JAVA_API_ARCHIVE_NAME/
cp -rf source/java_api/docs/* $JAVA_API_ARCHIVE_NAME/docs

mkdir $JAVA_API_ARCHIVE_NAME/modules
cp -f source/java_api/build/garoon2.jar $JAVA_API_ARCHIVE_NAME/modules
cp -rf encoded/source/java_api/src/phpLink/* $JAVA_API_ARCHIVE_NAME/modules

mkdir -p $JAVA_API_ARCHIVE_NAME/samples/application
cp -rf source/java_api/src/JavaLink/sample/application/classic/* $JAVA_API_ARCHIVE_NAME/samples/application
cp -rf source/java_api/src/JavaLink/sample/ldap $JAVA_API_ARCHIVE_NAME/samples/ldap
/usr/bin/find $JAVA_API_ARCHIVE_NAME -type d -print | xargs chmod 777
/usr/bin/find $JAVA_API_ARCHIVE_NAME -type f -print | xargs chmod 666

rm -f $JAVA_API_ARCHIVE_NAME.tar.gz
tar -czf $JAVA_API_ARCHIVE_NAME.tar.gz $JAVA_API_ARCHIVE_NAME
cp $JAVA_API_ARCHIVE_NAME.tar.gz archive
rm -f $JAVA_API_ARCHIVE_NAME.tar.gz
rm -rf $JAVA_API_ARCHIVE_NAME