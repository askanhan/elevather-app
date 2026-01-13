cd /cygdrive/C/workplace/burada/build/

echo '***** Builden *****'
npm run build

echo '***** Kopieren *****'
cp -u -r ./dist/. ../www/

echo '***** Naar smartphone *****'
cordova run android

