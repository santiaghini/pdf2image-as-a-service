#
# lambda.sh
#

# Get account ID
echo "Please enter your account ID"
read ACCT_ID

# Clean up before starting
rm -rf env/
rm -rf package/
rm function.zip

# Build poppler
rm -rf poppler_binaries/
./build_poppler.sh

# Make a virtualenv
virtualenv --python python3 env/
source env/bin/activate

# Creating the package
mkdir -p package
pip3 install pdf2image --target package/

# Moving the poppler libraries in the package
cp -r poppler_binaries/ package/

# Moving the function in the package
cp amazon/pdf2image_demo.py package/

# Zipping the package
cd package
zip -r9 ../function.zip *
cd ..

# Deleting package artifacts
rm -rf package/
