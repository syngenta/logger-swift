
# Geting version from tag
version=`git describe --abbrev=0 --tags`

# Change version in podspec
sed -i ".bak" "s/  s.version          = .*/  s.version          = '"$version"'/" logger.podspec

# Adding repo if needs
if [ "$(pod repo list | grep -e "cropio-specs")" -ge 0 ]; then
  pod repo add cropio-specs git@github.com:cropio/cocoapods-specs.git
fi

# Push library to repo
pod repo push cropio-specs logger.podspec --allow-warnings

# Back to primary
git checkout logger.podspec
