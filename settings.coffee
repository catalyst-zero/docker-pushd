exports.server =
    redis_port: 6379
    redis_host: process.env['REDIS_PORT_6379_TCP_ADDR']
    # redis_socket: '/var/run/redis/redis.sock'
    # redis_auth: 'password'
    tcp_port: 80
    udp_port: 80
    access_log: yes
    acl:
        # restrict publish access to private networks
        publish: ['127.0.0.1', '10.0.0.0/8', '172.16.0.0/12', '192.168.0.0/16']
#    auth:
#        # require HTTP basic authentication, username is 'admin' and
#        # password is 'password'
#        #
#        # HTTP basic authentication overrides IP-based authentication
#        # if both acl and auth are defined.
#        admin:
#            password: 'password'
#            realms: ['register', 'publish']

exports['event-source'] =
    enabled: yes

exports['apns'] =
    enabled: yes
    class: require('./lib/pushservices/apns').PushServiceAPNS
    # Convert cert.cer and key.p12 using:
    # $ openssl x509 -in cert.cer -inform DER -outform PEM -out apns-cert.pem
    # $ openssl pkcs12 -in key.p12 -out apns-key.pem -nodes
    cert: '/mnt/pushd/cert.pem'
    key: '/mnt/pushd/key.pem'
    cacheLength: 100
    # Selects data keys which are allowed to be sent with the notification
    # Keep in mind that APNS limits notification payload size to 256 bytes
    payloadFilter: ['messageFrom']
    gateway: process.env['APN_PUSH_GATEWAY']
    address: process.env['APN_FEEDBACK_ADDRESS']

exports['gcm'] =
    enabled: yes
    class: require('./lib/pushservices/gcm').PushServiceGCM
    key: process.env['GCM_API_KEY']

exports['http'] =
    enabled: no
    class: require('./lib/pushservices/http').PushServiceHTTP

exports['mpns-toast'] =
    enabled: no
    class: require('./lib/pushservices/mpns').PushServiceMPNS
    type: 'toast'
    # Used for WP7.5+ to handle deep linking
    paramTemplate: '/Page.xaml?object=${data.object_id}'

exports['mpns-tile'] =
    enabled: no
    class: require('./lib/pushservices/mpns').PushServiceMPNS
    type: 'tile'
    # Mapping defines where - in the payload - to get the value of each required properties
    tileMapping:
        # Used for WP7.5+ to push to secondary tiles
        # id: "/SecondaryTile.xaml?DefaultTitle=${event.name}"
        # count: "${data.count}"
        title: "${data.title}"
        backgroundImage: "${data.background_image_url}"
        backBackgroundImage: "#005e8a"
        backTitle: "${data.back_title}"
        backContent: "${data.message}"
        # param for WP8 flip tile (sent when subscriber declare a minimum OS version of 8.0)
        smallBackgroundImage: "${data.small_background_image_url}"
        wideBackgroundImage: "${data.wide_background_image_url}"
        wideBackContent: "${data.message}"
        wideBackBackgroundImage: "#005e8a"

exports['mpns-raw'] =
    enabled: no
    class: require('./lib/pushservices/mpns').PushServiceMPNS
    type: 'raw'
