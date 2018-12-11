name 'build_cookbook'
maintainer 'Larry Charbonneau'
maintainer_email 'larrycharbonneau4@gmail.com'
license 'gplv3'
version '0.1.0'
chef_version '>= 12.14' if respond_to?(:chef_version)

depends 'delivery-truck'
