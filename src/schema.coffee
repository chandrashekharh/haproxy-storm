schema_haproxy =
    name: "haproxy"
    type: "object"
    required: true
    additionalProperties: false
    properties:
        global:
            name: "global"
            type: "object"
            required: true            
            properties:
                'maxconn'          : {type:"string", required:false}
                'stats socket'     : {type:"string", required:false}
                'stats timeout'    : {type:"string", required:false} 
                'stats maxconn'    : {type:"string", required:false}
                'uid'              : {type:"string", required:false} 
                'gid'              : {type:"string", required:false}
                'group'            : {type:"string", required:false}
                'user'             : {type:"string", required:false}
                'log'              : {type:"string", required:false}
                'chroot'            : {type:"string", required:false}
                'daemon'            : {type:"string", required:false}
                'log-send-hostname'  : {type:"string", required:false}
                'nbproc'            : {type:"string", required:false}
                'pidfile'           : {type:"string", required:false}
                'ulimit-n'          : {type:"string", required:false}
                'node'              : {type:"string", required:false}
                'description'       : {type:"string", required:false}
                'maxpipes'          : {type:"string", required:false}
        defaults:
            name: "defaults"
            type: "object"
            required: false            
            properties:
                'backlog'          : {type:"string", required:false}
        listen:
            name: "listen"
            type: "object"
            required: false            
            properties:
                'acl'          : {type:"string", required:false}
        frontends:
            type: "array"
            items:
                name: "frontend"
                type: "object"
                required: false                        
                properties:
                    'name'            : {type:"string", required:false}                    
                    'mode'            : {type:"string", required:false}     
                    'log'             : {type:"string", required:false}     
                    'option'          : {type:"string", required:false}     
                    'monitor-uri'     : {type:"string", required:false}     
                    'maxconn'         : {type:"string", required:false}     
                    'timeout'         : {type:"string", required:false}     
                    'stats uri'       : {type:"string", required:false}     
                    'use_backend'     : {type:"string", required:false}     
                    'default_backend' : {type:"string", required:false}
        backends:
            type: "array"
            items:
                name: "backend"
                type: "object"
                required: false                        
                properties:
                    'name'          : {type:"string", required:false}     
                    'mode'          : {type:"string", required:false}     
                    'balance'       : {type:"string", required:false}     
                    'retries'       : {type:"string", required:false}     
                    'option'        : {type:"string", required:false}     
                    'stick-table-type': {type:"string", required:false}     
                    'stick'         : {type:"string", required:false}     
                    'reqrep'        : {type:"string", required:false}     
                    'reqadd'        : {type:"string", required:false}     
                    'timeout server' : {type:"string", required:false}     
                    'timeout queue' : {type:"string", required:false}     
                    'timeout connect': {type:"string", required:false}     
                    'option httpchk': {type:"string", required:false}     
                    'cookie'        : {type:"string", required:false}     

module.exports = schema_haproxy