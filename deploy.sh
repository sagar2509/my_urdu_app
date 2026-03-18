# deploy.sh
flutter build web --release --base-href "/my_urdu_app/"
cd build/web
git init
git checkout -b gh-pages
git add .
git commit -m "Auto-deploy"
git remote add origin git@github.com:sagar2509/my_urdu_app.git
git push origin gh-pages --force