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
    $uid     = 500
    $gid     = 500
    $homedir = '/home/rsmart'
    $basedir = '/home/rsmart/sakaioae'

    ###########################################################################
    # Nodes
    
    $app_server1 = '10.51.11.100'
    $app_server2 = '10.51.11.101'
    $nfs_server  = '10.51.11.90'
    $db_server   = '10.51.11.70'
    $solr_master = '10.51.11.30'

	# prod-cle
    $cle_server1  = '10.51.10.16'
    $cle_server2  = '10.51.10.17'

    ###########################################################################
    # Database setup
    $oae_db          = 'nak'
    $oae_db_url      = "jdbc:postgresql://${db_server}/${db}?charSet\\=UTF-8"
    $oae_db_driver   = 'org.postgresql.Driver'
    $oae_db_user     = 'nakamura'
    $oae_db_password = 'ironchef'

    ###########################################################################
    # Content body storage
    $oae_nfs_share   = '/export/files-academic'
    $oae_nfs_mountpoint = '/files-academic'
    $oae_nfs_options = '_netdev,rw,rsize=8192,wsize=8192'

    $storedir    = "/files-academic/store"
    ###########################################################################
    # Git (Preview processor)
    $nakamura_zip = 'https://nodeload.github.com/rSmart/nakamura/zipball/develop'
    $solr_tarball = 'https://nodeload.github.com/rSmart/solr/tarball/1.3.2-rsmart'

    ###########################################################################
    # Apache load balancer
    $http_name           = 'cole.uconline.edu'
    $http_name_untrusted = 'content-cole.uconline.edu'
    # $http_name           = 'oipp-prod2.academic.rsmart.com'
    # $http_name_untrusted = 'oipp-content.academic.rsmart.com'
    $apache_lb_members           = [ "${app_server1}:8080", "${app_server2}:8080" ]
    $apache_lb_members_untrusted = [ "${app_server1}:8082", "${app_server2}:8082" ]
    $apache_lb_params            = ["retry=20", "min=3", "flushpackets=auto", "max=1", "loadfactor=100", "timeout=300"]

    $mock_cle_content = false
    $apache_cle_lb_members = [ "${cle_server1}:8009 route=OIPP-CLE1", "${cle_server2}:8009 route=OIPP-CLE2" ]
    $apache_cle_location_match = "^/(xsl-portal.*|access.*|courier.*|dav.*|direct.*|imsblti.*|library.*|messageforums-tool.*|osp-common-tool.*|polls-tool.*|portal.*|profile-tool.*|profile2-tool.*|sakai.*|samigo-app.*|scheduler-tool.*|rsmart-customizer-tool.*|oauth-tool.*|emailtemplateservice-tool.*|sitestats-tool.*|rsmart-support-tool.*|mailsender-tool.*|tool.css|portool_base.css|scormcloud-tool.*)" 
    $cle_dav_server0 = '10.52.10.19'
    $locations_noproxy = ['/server-status', '/balancer-manager', '/Shibboleth.sso', '/access', '/imsblti']

    $oae_cert = "puppet:///modules/localconfig/uconline.edu.crt"
    $oae_key = "puppet:///modules/localconfig/uconline.edu.key"
    $oae_certchain = "puppet:///modules/localconfig/uconline.edu-intermediate.crt"

    ###########################################################################
    # App servers
    $jarsource     = '/home/rsmart/com.rsmart.academic.app.oipp-1.1.3-rsmart.jar'
    $java          = '/usr/java/jdk1.6.0_30/bin/java'
    $javamemorymax = '5g'
    $javamemorymin = '5g'
    $javapermsize  = '256m'

    $admin_password = 'e4D7kYbQgswCHp'

    # These hosts can access /system/console
    $oae_admin_hosts = ['72.44.192.164', ]

    # oae server protection service
    $serverprotectsec = 'M9LjpkmNioYEZD81BBffC4QzRAiHpJ8'
    $sps_disabled = false

    # ehcache
    $ehcache_tcp_port = '40001'
    $ehcache_remote_object_port = '40002'

    # solr
    $solr_remoteurl = "http://${solr_master}:8080/solr"

    #CLE
    $basiclti_secret = "rLKQsw6YBq4TUa"
    $basiclti_key = "ColeUconlineEdu"
    $basiclti_tool_list = ["sakai.gradebook.gwt.rpc","sakai.assignment.grades","sakai.samigo","sakai.schedule","sakai.announcements","sakai.postem","sakai.profile2","sakai.profile","sakai.chat","sakai.resources","sakai.dropbox","sakai.rwiki","sakai.forums","sakai.gradebook.tool","sakai.mailbox","sakai.singleuser","sakai.messages","sakai.site.roster","sakai.news","sakai.summary.calendar","sakai.poll","sakai.syllabus","sakai.blogwow","sakai.sitestats","sakai.sections"]

    $tomcat_user    = 'admin'
    $tomcat_password = 'pulp134@rain'

    # outgoing email
    $reply_as_address = 'noreply@rsmart.com'
    $reply_as_name = 'rSmart'

    ###########################################################################
    # SIS Integration
    $basic_sis_batch_executable_artifact = 'com.rsmart.nakamura.basic-sis-batch-1.0.3-executable.jar'
    $basic_sis_batch_executable_url = 'http://rsmart-dev.s3.amazonaws.com/artifacts/maven/release/com/rsmart/com.rsmart.nakamura.basic-sis-batch/1.0.3/com.rsmart.nakamura.basic-sis-batch-1.0.3-executable.jar'
    # $basic_sis_batch_email_report = "provision@uconline.edu"
    $basic_sis_batch_email_report = "mike@rSmart.com"

    $oae_csv_dir = '/files-academic/sis/'
    $cle_csv_dir = '/files-cle/files/sis/'

    $sis_archive_dir = "${homedir}/sis-failed-transfers"
    $csv_object_types = [ 'Course', 'Membership', 'Section', 'SectionMembership']

    $cle_csv_files = ['Course', 'Membership', 'Section', 'SectionMembership']
    $oae_csv_files = ['Course', 'Membership', 'Section', 'SectionMembership', 'User']

    $sis_batch_transfers = {
        'rsmart@oipp-cle1:/files-cle/files/sis/'        => $cle_csv_files,
        'rsmart@oipp-prod-app1:/files-academic/sis/'    => $oae_csv_files,
        'rsmart@oipp-cle1:/files-cle/files/sis/test'    => $cle_csv_files,
        'rsmart@oipp-test:~/sistest'                    => $oae_csv_files,
    }

    $sis_test_batch_transfers = {
        'rsmart@oipp-cle1:/files-cle/files/sis/test'    => $cle_csv_files,
        'rsmart@oipp-test:~/sistest'                    => $oae_csv_files,
    }

    $basic_sis_batch_school_properties = {
        # 'UCB' => {
        #     'upload_dir'          => '/home/ucb_sis',
        #     'test_upload_dir'     => '/home/ucb_sis/test',
        # },
        'UCD' => {
            'upload_dir'          => '/home/ucd_sis',
            'test_upload_dir'     => '/home/ucd_sis/test',
        },
        # 'UCMerced' => {
        #     'upload_dir'          => '/home/ucm_sis',
        #     'test_upload_dir'     => '/home/ucm_sis/test',
        # },
        'UCLA' => {
            'upload_dir'          => '/home/ucla_sis',
            'test_upload_dir'     => '/home/ucla_sis/test',
        },
    }

    # x-sakai-token server-to-server authn semantics
    $trusted_shared_secret = "3pWkFWkybjnxKLKqrXdQTqIhmDRWExBXsxBKiLexTGJdJ4bhUP"

    ###########################################################################
    # App Dynamics setup
    $appDynAppName='OIPP'
    $appDynTier='OAE'
    $appDynControllerHost='oipp-appdyn'
    $appDynControllerPort='8090'

}
