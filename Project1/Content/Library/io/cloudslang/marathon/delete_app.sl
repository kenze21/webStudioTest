#   (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
#   All rights reserved. This program and the accompanying materials
#   are made available under the terms of the Apache License v2.0 which accompany this distribution.
#
#   The Apache License is available at
#   http://www.apache.org/licenses/LICENSE-2.0
#
####################################################
#!!
#! @description: Deletes a Marathon app.
#! @input marathon_host: Marathon agent host
#! @input marathon_port: optional - Marathon agent port - Default: '8080'
#! @input app_id: app ID to delete
#! @input proxy_host: optional - proxy host
#! @input proxy_port: optional - proxy port
#! @output return_result: response of the operation
#! @output error_message: return_result if return_code == '-1' or status_code != '200'
#! @output return_code: if return_code == '-1' then there was an error
#! @output status_code: normal status code is '200'
#! @result SUCCESS: operation succeeded (return_code != '-1' and status_code == '200')
#! @result FAILURE: otherwise
#!!#
####################################################

namespace: io.cloudslang.marathon

operation:
  name: delete_app
  inputs:
    - marathon_host
    - marathon_port:
        default: "8080"
        required: false
    - app_id
    - url:
        default: ${'http://' + marathon_host + ':' + marathon_port + '/v2/apps/' +app_id}
        private: true
    - method:
        default: "delete"
        private: true
    - contentType:
        default: "application/json"
        private: true
    - proxy_host:
        required: false
    - proxyHost:
        default: ${get('proxy_host', None)}
        required: false
    - proxy_port:
            required: false
    - proxyPort:
        default: ${get('proxy_port', None)}
        required: false

  java_action:
    class_name: io.cloudslang.content.httpclient.HttpClientAction
    method_name: execute
  outputs:
    - return_result: ${returnResult}
    - error_message: ${returnResult if returnCode == '-1' or statusCode != '200' else ''}
    - return_code: ${returnCode}
    - status_code: ${statusCode}
  results:
    - SUCCESS: ${returnCode != '-1' and statusCode == '200'}
    - FAILURE
