# = Class: oae::preview_processor::amazon
#
# Set up the preview processor on a redhat machine
#
class oae::preview_processor::amazon {

    Class['oae::params'] -> Class['oae::preview_processor::packages']
    
    $common_packages = [ 'cronie', 'cpp', 'gcc', 'gcc-c++',
        'fontconfig-devel', 'libcurl-devel',
        'GraphicsMagick', 'ImageMagick', 'ImageMagick-devel',
        'poppler-utils', 'rubygems', 'libgcj', ]

    package { $common_packages: ensure => installed }

    if !defined(Package['ruby-devel']) {
        package { 'ruby-devel': ensure => installed }
    }

    exec { 'yum-install-tk-centos6-repo':
        command => "yum -y -t --enablerepo=centos6-base install tk",
        unless  => 'rpm -q tk',
    }

    package { 'pdftk-1.44-1.el6.rf.x86_64':
         ensure   => present,
         source   => "http://dl.dropbox.com/u/24606888/puppet-oae-files/pdftk-1.44-1.el6.rf.x86_64.rpm",
         provider => 'rpm',
         require  => Package['libgcj']
    }
}
