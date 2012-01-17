#
# Use this class to configure a specific OAE cluster.
# In your nodes file refer to these variables as $localconfig::variable_name.
#
class localconfig {
    
    Class['localconfig::hosts'] -> Class['localconfig']

    ###########################################################################
    # OS
    $user    = 'rsmart'
    $group   = 'rsmart'
    $uid     = 8080
    $gid     = 8080
    $basedir = '/home/rsmart'

    ###########################################################################
    # Nodes
    
    # staging-app1
    $app_server1 = '10.53.10.16'
    # staging-app2
    $app_server2 = '10.53.10.20'
    # staging-nfs
    $nfs_server  = '10.53.10.13'
    # staging-cle
    $cle_server  = '10.53.10.17'
    # staging-dbserv1
    $db_server   = '10.53.10.10'
    

    ###########################################################################
    # Database setup
    $db          = 'nak'
    $db_url      = "jdbc:postgresql://${db_server}/${db}?charSet\\=UTF-8"
    $db_driver   = 'org.postgresql.Driver'
    $db_user     = 'nakamura'
    $db_password = 'ironchef'

    ###########################################################################
    $storedir    = "${basedir}/store"
    $nfs_share   = '/export/oae-staging'
    $nfs_options = 'defaults'

    ###########################################################################
    # Git (Preview processor)
    $nakamura_git = "http://github.com/rsmart/nakamura.git"
    $nakamura_tag = "1.1"

    ###########################################################################
    # Apache load balancer
    $http_name                   = 'staging.academic.rsmart.com'
    $apache_lb_members           = [ "${app_server1}:8080", "${app_server2}:8080" ]
    $apache_lb_members_untrusted = [ "${app_server1}:8082", "${app_server2}:8082" ]
    
    $apache_cle_lb_members = [ "${cle_server}:8009 route=cle1", "${cle_server}:8010 route=cle2" ]
    $apache_cle_location_match = "^/(xsl-portal.*|access.*|courier.*|dav.*|direct.*|imsblti.*|library.*|messageforums-tool.*|osp-common-tool.*|polls-tool.*|portal.*|profile-tool.*|profile2-tool.*|sakai.*|samigo-app.*|scheduler-tool.*|rsmart-customizer-tool.*|oauth-tool.*|emailtemplateservice-tool.*|sitestats-tool.*|rsmart-support-tool.*|mailsender-tool.*|tool.css|portool_base.css)"
    $cle_dav_server0 = '10.53.10.19'

    ###########################################################################
    # App servers
    $jarsource     = '/home/rsmart/com.rsmart.academic.app-1.1.0-M1-QA1.jar'
    $jarfile       = 'com.rsmart.academic.app-1.1.0-M1-QA1.jar'
    $javamemorymax = '4096'
    $javamemorymin = '4096'
    $javapermsize  = '256'

    # These hosts can access /system/console
    $oae_admin_hosts = ['72.44.192.164', ]

    # oae server protection service
    $serverprotectsec = 'shhh-its@secret'

    # ehcache
    $ehcache_tcp_port = '40001'

    # solr
    $solr_master = '10.50.10.42'
    $solr_slave0 = '10.50.10.47' # TODO fix!
    $solr_remoteurl = "http://${solr_master}:8983/solr"
    $solr_queryurls = "http://${solr_master}:8983/solr|http://${solr_slave0}:8983/solr"
}
