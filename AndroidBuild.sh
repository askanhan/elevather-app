echo '**** SVN updaten ****'
cd ..
svn update
echo '**** builder updaten ****'
cd ./build
npm run build 
echo '***** Kopiëren naar www map *****'
cp -r ./dist/. ./../www/
echo '***** cordova build iOS *****'
cd ..
cordova build ios