#  Phusion Passenger - https://www.phusionpassenger.com/
#  Copyright (c) 2013-2018 Phusion Holding B.V.
#
#  "Passenger", "Phusion Passenger" and "Union Station" are registered
#  trademarks of Phusion Holding B.V.
#
#  Permission is hereby granted, free of charge, to any person obtaining a copy
#  of this software and associated documentation files (the "Software"), to deal
#  in the Software without restriction, including without limitation the rights
#  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#  copies of the Software, and to permit persons to whom the Software is
#  furnished to do so, subject to the following conditions:
#
#  The above copyright notice and this permission notice shall be included in
#  all copies or substantial portions of the Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#  THE SOFTWARE.

# This file defines all supported Nginx configuration options. The
# build system automatically generates the corresponding Nginx module boilerplate
# code from the definitions in this file.
#
# Main configuration options are not defined in this file, but are defined in
# src/nginx_module/Configuration.c instead.
#
# The following boilerplate code is generated:
#
#  * ngx_command_t array members (ConfigGeneral/AutoGeneratedDefinitions.c.cxxcodebuilder)
#  * Configuration structure definition ({MainConfig,LocationConfig}/AutoGeneratedStruct.h.cxxcodebuilder)
#  * Configuration structure initialization ({MainConfig/LocationConfig}/AutoGeneratedCreateFunction.c.cxxcodebuilder)
#  * Configuration merging (LocationConfig/AutoGeneratedMergeFunction.c.cxxcodebuilder)
#  * Struct field setter functions (ConfigGeneral/AutoGeneratedSetterFuncs.cpp.cxxcodebuilder)
#  * Nginx module <-> Core headers serialization code (LocationConfig/AutoGeneratedHeaderSerialization.c.cxxcodebuilder)
#
# Options:
#
#  * name - The configuration option name. Required.
#  * scope - The scope that applies to this configuration. Required. One of:
#            :global, :application, :location
#  * context - The context in which this configuration option is valid.
#              Defaults to [:main, :srv, :loc, :lif]
#  * type - This configuration option's value type. Allowed types:
#           :string, :integer, :uinteger, :flag, :string_array, :string_keyval,
#           :path, :msec
#  * default - A static default value. Set during configuration merging,
#              and reported in the tracking code that generates the
#              configuration manifest.
#  * dynamic_default - If this option has a default, but it's dynamically inferred
#              (and not a static value) then set this option to a human-readable
#              description that explains how the default is dynamically inferred.
#              Reported in the tracking code that generates the configuration
#              manifest.
#  * take - Tells Nginx how many parameters and what kind of parameter
#           this configuration option takes. It should be set to a string
#           such as "NGX_CONF_FLAG".
#           By default this is automatically inferred from `type`: for
#           example if `type` is :string then ConfigurationCommands.cxxcodebuilder.erb
#           will infer that `NGX_CONF_TAKE1` should be used.
#  * function - The name of the function that should be used to store the
#               configuration value into the corresponding structure. This function
#               is not auto-generated, so it must be the name of an existing
#               function. By default, the function name is automatically inferred
#               from `type`. For example if `type` is string then `function` is
#               inferred to be `ngx_conf_set_str_slot`.
#               If you set this to a string then you are responsible for defining
#               said function in Configuration.c.
#  * struct - The type of the struct that the field is contained in. Something like
#             "NGX_HTTP_LOC_CONF_OFFSET" (which is also the default).
#  * field - The name that should be used for the auto-generated field in
#            the configuration structure. Defaults to the configuration
#            name without the 'passenger_' prefix. Set this to nil if you do not
#            want a structure field to be auto-generated. If the field name contains
#            a dot (.e.g `upstream_config.pass_headers`) then the structure field will
#            also not be auto-generated, because it is assumed to belong to an existing
#            structure field.
#  * post - The extra information needed by function for post-processing.
#  * header - The name of the corresponding CGI header. By default CGI header
#             generation code is automatically generated, using the configuration
#             option's name in uppercase as the CGI header name.
#             Setting this to nil, or setting `field` to a value containing a dot,
#             will disable auto-generation of CGI header generation code. You are
#             then responsible for writing CGI header passing code yourself in
#             ContentHandler.c.
#  * auto_generate_nginx_create_code - Whether configuration initialization
#            code should be automatically generated. Defaults to true. If you set
#            this to false then you are responsible for writing initialization code
#            yourself in Configuration.c.
#  * auto_generate_nginx_merge_code - Whether configuration merging
#            code should be automatically generated. Defaults to true. If you set
#            this to false then you are responsible for writing merging code
#            yourself in Configuration.c.
#  * auto_generate_nginx_tracking_code - Whether configuration hierarchy
#            tracking code should be automatically generated. Defaults to true.
#            If you set this to false then you are responsible for writing
#            configuration tracking code yourself in Configuration.c.
#  * alias_for - Set this if this configuration option is an alias for another
#                option. Alias definitions must only have the `name` and `alias_for`
#                fields, nothing else.

PhusionPassenger.require_passenger_lib 'constants'

NGINX_CONFIGURATION_OPTIONS = [
  ###### Global configuration ######

  {
    :name     => 'passenger_root',
    :scope    => :global,
    :type     => :string,
    :context  => [:main],
    :struct   => 'NGX_HTTP_MAIN_CONF_OFFSET',
    :field    => 'root_dir'
  },
  {
    :name     => 'passenger_ctl',
    :scope    => :global,
    :type     => :string_keyval,
    :context  => [:main],
    :struct   => 'NGX_HTTP_MAIN_CONF_OFFSET'
  },
  {
    :name     => 'passenger_abort_on_startup_error',
    :scope    => :global,
    :type     => :flag,
    :default  => false,
    :context  => [:main],
    :struct   => 'NGX_HTTP_MAIN_CONF_OFFSET'
  },
  {
    :name     => 'passenger_dump_config_manifest',
    :scope    => :global,
    :type     => :string,
    :context  => [:main],
    :struct   => 'NGX_HTTP_MAIN_CONF_OFFSET'
  },
  {
    :name     => 'passenger_log_level',
    :scope    => :global,
    :type     => :uinteger,
    :default  => DEFAULT_LOG_LEVEL,
    :context  => [:main],
    :struct   => 'NGX_HTTP_MAIN_CONF_OFFSET'
  },
  {
    :name     => 'passenger_log_file',
    :scope    => :global,
    :type     => :string,
    :dynamic_default => "Nginx's global error log",
    :context  => [:main],
    :struct   => 'NGX_HTTP_MAIN_CONF_OFFSET'
  },
  {
    :name     => 'passenger_disable_log_prefix',
    :scope    => :global,
    :type     => :flag,
    :default  => false,
    :context  => [:main],
    :struct   => 'NGX_HTTP_MAIN_CONF_OFFSET'
  },
  {
    :name     => 'passenger_file_descriptor_log_file',
    :scope    => :global,
    :type     => :string,
    :context  => [:main],
    :struct   => 'NGX_HTTP_MAIN_CONF_OFFSET'
  },
  {
    :name     => 'passenger_data_buffer_dir',
    :scope    => :global,
    :type     => :string,
    :dynamic_default => '$TMPDIR, or if not given, /tmp',
    :context  => [:main],
    :struct   => 'NGX_HTTP_MAIN_CONF_OFFSET'
  },
  {
    :name     => 'passenger_socket_backlog',
    :scope    => :global,
    :type     => :uinteger,
    :default  => DEFAULT_SOCKET_BACKLOG,
    :context  => [:main],
    :struct   => "NGX_HTTP_MAIN_CONF_OFFSET"
  },
  {
    :name     => 'passenger_core_file_descriptor_ulimit',
    :scope    => :global,
    :type     => :uinteger,
    :dynamic_default => 'The ulimits environment under which Nginx was started',
    :context  => [:main],
    :struct   => 'NGX_HTTP_MAIN_CONF_OFFSET'
  },
  {
    :name     => 'passenger_disable_security_update_check',
    :scope    => :global,
    :type     => :flag,
    :default  => false,
    :context  => [:main],
    :struct   => 'NGX_HTTP_MAIN_CONF_OFFSET'
  },
  {
    :name     => 'passenger_security_update_check_proxy',
    :scope    => :global,
    :type     => :string,
    :context  => [:main],
    :struct   => 'NGX_HTTP_MAIN_CONF_OFFSET'
  },
  {
    :name     => 'passenger_disable_anonymous_telemetry',
    :scope    => :global,
    :type     => :flag,
    :default  => false,
    :context  => [:main],
    :struct   => 'NGX_HTTP_MAIN_CONF_OFFSET'
  },
  {
    :name     => 'passenger_anonymous_telemetry_proxy',
    :scope    => :global,
    :type     => :string,
    :context  => [:main],
    :struct   => 'NGX_HTTP_MAIN_CONF_OFFSET'
  },
  {
    :name     => 'passenger_pre_start',
    :scope    => :global,
    :type     => :string_array,
    :context  => [:main],
    :struct   => 'NGX_HTTP_MAIN_CONF_OFFSET',
    :field    => 'prestart_uris'
  },
  {
    :name     => 'passenger_instance_registry_dir',
    :scope    => :global,
    :type     => :string,
    :dynamic_default => 'Either /var/run/passenger-instreg, $TMPDIR, or /tmp (see docs)',
    :context  => [:main],
    :struct   => 'NGX_HTTP_MAIN_CONF_OFFSET'
  },
  {
    :name     => 'passenger_spawn_dir',
    :scope    => :global,
    :type     => :string,
    :dynamic_default => 'Either $TMPDIR or /tmp',
    :context  => [:main],
    :struct   => 'NGX_HTTP_MAIN_CONF_OFFSET'
  },
  {
    :name     => 'passenger_turbocaching',
    :scope    => :global,
    :type     => :flag,
    :default  => true,
    :context  => [:main],
    :struct   => 'NGX_HTTP_MAIN_CONF_OFFSET'
  },
  {
    :name     => 'passenger_user_switching',
    :scope    => :global,
    :type     => :flag,
    :default  => true,
    :context  => [:main],
    :struct   => 'NGX_HTTP_MAIN_CONF_OFFSET'
  },
  {
    :name     => 'passenger_default_user',
    :scope    => :global,
    :type     => :string,
    :default  => PASSENGER_DEFAULT_USER,
    :context  => [:main],
    :struct   => 'NGX_HTTP_MAIN_CONF_OFFSET'
  },
  {
    :name     => 'passenger_default_group',
    :scope    => :global,
    :type     => :string,
    :dynamic_default => 'The primary group of passenger_default_user',
    :context  => [:main],
    :struct   => 'NGX_HTTP_MAIN_CONF_OFFSET'
  },
  {
    :name     => 'passenger_max_pool_size',
    :scope    => :global,
    :type     => :uinteger,
    :default  => DEFAULT_MAX_POOL_SIZE,
    :context  => [:main],
    :struct   => 'NGX_HTTP_MAIN_CONF_OFFSET'
  },
  {
    :name     => 'passenger_pool_idle_time',
    :scope    => :global,
    :type     => :uinteger,
    :default  => DEFAULT_POOL_IDLE_TIME,
    :context  => [:main],
    :struct   => 'NGX_HTTP_MAIN_CONF_OFFSET'
  },
  {
    :name     => 'passenger_response_buffer_high_watermark',
    :scope    => :global,
    :type     => :uinteger,
    :default  => DEFAULT_RESPONSE_BUFFER_HIGH_WATERMARK,
    :context  => [:main],
    :struct   => 'NGX_HTTP_MAIN_CONF_OFFSET'
  },
  {
    :name     => 'passenger_stat_throttle_rate',
    :scope    => :global,
    :type     => :uinteger,
    :default  => DEFAULT_STAT_THROTTLE_RATE,
    :context  => [:main],
    :struct   => 'NGX_HTTP_MAIN_CONF_OFFSET'
  },
  {
    :name     => 'passenger_show_version_in_header',
    :scope    => :global,
    :type     => :flag,
    :default  => true,
    :context  => [:main],
    :struct   => 'NGX_HTTP_MAIN_CONF_OFFSET'
  },
  {
    :name     => 'passenger_app_file_descriptor_ulimit',
    :scope    => :global,
    :type     => :uinteger,
    :dynamic_default => 'passenger_core_file_descriptor_ulimit',
    :struct   => 'NGX_HTTP_MAIN_CONF_OFFSET'
  },
  {
    :name     => 'passenger_max_instances_per_app',
    :scope    => :global,
    :context  => [:main],
    :type     => :uinteger,
    :header   => nil,
    :default  => 0,
    :struct   => 'NGX_HTTP_MAIN_CONF_OFFSET'
  },
  {
    :name     => 'passenger_admin_panel_url',
    :scope    => :global,
    :type     => :string,
    :context  => [:main],
    :struct   => 'NGX_HTTP_MAIN_CONF_OFFSET'
  },
  {
    :name     => 'passenger_admin_panel_auth_type',
    :scope    => :global,
    :type     => :string,
    :context  => [:main],
    :struct   => 'NGX_HTTP_MAIN_CONF_OFFSET'
  },
  {
    :name     => 'passenger_admin_panel_username',
    :scope    => :global,
    :type     => :string,
    :context  => [:main],
    :struct   => 'NGX_HTTP_MAIN_CONF_OFFSET'
  },
  {
    :name     => 'passenger_admin_panel_password',
    :scope    => :global,
    :type     => :string,
    :context  => [:main],
    :struct   => 'NGX_HTTP_MAIN_CONF_OFFSET'
  },


  ###### Per-application configuration ######

  {
    :name     => 'passenger_ruby',
    :scope    => :application,
    :type     => :string,
    :default  => DEFAULT_RUBY
  },
  {
    :name     => 'passenger_python',
    :scope    => :application,
    :type     => :string,
    :default  => DEFAULT_PYTHON
  },
  {
    :name     => 'passenger_nodejs',
    :scope    => :application,
    :type     => :string,
    :default  => DEFAULT_NODEJS
  },
  {
    :name     => 'passenger_meteor_app_settings',
    :scope    => :application,
    :type     => :string
  },
  {
    :name     => 'passenger_app_env',
    :scope    => :application,
    :type     => :string,
    :default  => 'production',
    :field    => 'environment'
  },
  {
    :name     => 'passenger_friendly_error_pages',
    :scope    => :application,
    :type     => :flag,
    :dynamic_default => 'On if passenger_app_env is development, off otherwise'
  },
  {
    :name     => 'passenger_min_instances',
    :scope    => :application,
    :type     => :uinteger,
    :default  => 1,
    :header   => 'PASSENGER_MIN_PROCESSES'
  },
  {
    :name     => 'passenger_start_timeout',
    :scope    => :application,
    :type     => :uinteger,
    :default  => DEFAULT_START_TIMEOUT / 1000
  },
  {
    :name     => 'passenger_user',
    :scope    => :application,
    :type     => :string,
    :dynamic_default => 'See the user account sandboxing rules'
  },
  {
    :name     => 'passenger_group',
    :scope    => :application,
    :type     => :string,
    :dynamic_default => 'See the user account sandboxing rules'
  },
  {
    :name     => 'passenger_app_group_name',
    :scope    => :application,
    :type     => :string,
    :dynamic_default => 'passenger_app_root plus passenger_app_env'
  },
  {
    :name     => 'passenger_monitor_log_file',
    :scope    => :application,
    :type     => :string_array,
    :header   => nil
  },
  {
    :name     => 'passenger_app_root',
    :scope    => :application,
    :type     => :string,
    :dynamic_default => "Parent directory of the associated Nginx virtual host's root directory"
  },
  {
    :name     => 'passenger_app_rights',
    :scope    => :application,
    :type     => :string
  },
  {
    :name     => 'passenger_debugger',
    :scope    => :application,
    :type     => :flag,
    :default  => false
  },
  {
    :name     => 'passenger_max_preloader_idle_time',
    :scope    => :application,
    :type     => :integer,
    :default  => DEFAULT_MAX_PRELOADER_IDLE_TIME
  },
  {
    :name     => 'passenger_env_var',
    :scope    => :application,
    :type     => :string_keyval,
    :field    => 'env_vars',
    :header   => nil
  },
  {
    :name     => 'passenger_spawn_method',
    :scope    => :application,
    :dynamic_default => "'smart' for Ruby apps, 'direct' for all other apps",
    :type     => :string
  },
  {
    :name     => 'passenger_load_shell_envvars',
    :scope    => :application,
    :type     => :flag,
    :default  => true
  },
  {
    :name     => 'passenger_max_request_queue_size',
    :scope    => :application,
    :type     => :uinteger,
    :default  => DEFAULT_MAX_REQUEST_QUEUE_SIZE
  },
  {
    :name     => 'passenger_app_type',
    :scope    => :application,
    :type     => :string,
    :dynamic_default => 'Autodetected',
    :header   => nil
  },
  {
    :name     => 'passenger_startup_file',
    :scope    => :application,
    :type     => :string,
    :dynamic_default => 'Autodetected'
  },
  {
    :name     => 'passenger_app_start_command',
    :scope    => :application,
    :type     => :string,
    :header   => nil
  },
  {
    :name     => 'passenger_restart_dir',
    :scope    => :application,
    :type     => :string,
    :default  => 'tmp'
  },
  {
    :name     => 'passenger_abort_websockets_on_process_shutdown',
    :scope    => :application,
    :type     => :flag,
    :default  => true
  },
  {
    :name     => 'passenger_force_max_concurrent_requests_per_process',
    :scope    => :application,
    :type     => :integer,
    :default  => -1
  },

  ###### Per-location/per-request configuration ######

  {
    :name     => 'passenger_enabled',
    :scope    => :location,
    :type     => :flag,
    :default  => false,
    :function => 'passenger_enabled',
    :field    => 'enabled',
    :header   => nil
  },
  {
    :name     => 'passenger_max_requests',
    :scope    => :location,
    :type     => :uinteger,
    :default  => 0
  },
  {
    :name     => 'passenger_base_uri',
    :scope    => :location,
    :type     => :string_array,
    :field    => 'base_uris',
    :header   => nil
  },
  {
    :name     => 'passenger_document_root',
    :scope    => :location,
    :type     => :string,
    :header   => nil
  },
  {
    :name     => 'passenger_temp_path',
    :scope    => :location,
    :type     => :string,
    :function => 'ngx_conf_set_path_slot',
    :field    => 'upstream_config.temp_path',
    :auto_generate_nginx_tracking_code => false
  },
  {
    :name     => 'passenger_ignore_headers',
    :scope    => :location,
    :take     => 'NGX_CONF_1MORE',
    :function => 'ngx_conf_set_bitmask_slot',
    :field    => 'upstream_config.ignore_headers',
    :post     => '&ngx_http_upstream_ignore_headers_masks',
    :auto_generate_nginx_tracking_code => false
  },
  {
    :name     => 'passenger_set_header',
    :scope    => :location,
    :type     => :string_keyval,
    :field    => 'headers_source',
    :header   => nil,
    :auto_generate_nginx_create_code => false,
    :auto_generate_nginx_merge_code  => false
  },
  {
    :name     => 'passenger_pass_header',
    :scope    => :location,
    :type     => :string_array,
    :field    => 'upstream_config.pass_headers'
  },
  {
    :name     => 'passenger_headers_hash_max_size',
    :scope    => :location,
    :type     => :uinteger,
    :header   => nil,
    :default  => 512
  },
  {
    :name     => 'passenger_headers_hash_bucket_size',
    :scope    => :location,
    :type     => :uinteger,
    :header   => nil,
    :default  => 64
  },
  {
    :name     => 'passenger_ignore_client_abort',
    :scope    => :location,
    :type     => :flag,
    :default  => false,
    :field    => 'upstream_config.ignore_client_abort'
  },
  {
    :name     => 'passenger_read_timeout',
    :scope    => :location,
    :type     => :msec,
    :field    => 'upstream_config.read_timeout'
  },
  {
    :name     => 'passenger_buffer_response',
    :scope    => :location,
    :type     => :flag,
    :default  => false,
    :field    => 'upstream_config.buffering'
  },
  {
    :name     => 'passenger_buffer_size',
    :scope    => :location,
    :dynamic_default => '4k|8k',
    :take     => 'NGX_CONF_TAKE1',
    :function => 'ngx_conf_set_size_slot',
    :field    => 'upstream_config.buffer_size',
    :auto_generate_nginx_tracking_code => false
  },
  {
    :name     => 'passenger_buffers',
    :scope    => :location,
    :dynamic_default => '8 4k|8k',
    :take     => 'NGX_CONF_TAKE2',
    :function => 'ngx_conf_set_bufs_slot',
    :field    => 'upstream_config.bufs',
    :auto_generate_nginx_tracking_code => false
  },
  {
    :name     => 'passenger_busy_buffers_size',
    :scope    => :location,
    :dynamic_default => '8k|16k',
    :take     => 'NGX_CONF_TAKE1',
    :function => 'ngx_conf_set_size_slot',
    :field    => 'upstream_config.busy_buffers_size_conf',
    :auto_generate_nginx_tracking_code => false
  },
  {
    :name     => 'passenger_request_buffering',
    :scope    => :location,
    :type     => :flag,
    :default  => true,
    :field    => 'upstream_config.request_buffering',
    :function => 'passenger_conf_set_request_buffering'
  },
  {
    :name     => 'passenger_intercept_errors',
    :scope    => :location,
    :type     => :flag,
    :default  => false,
    :field    => 'upstream_config.intercept_errors'
  },
  {
    :name     => 'passenger_request_queue_overflow_status_code',
    :scope    => :location,
    :type     => :integer,
    :default  => 503
  },
  {
    :name     => 'passenger_buffer_upload',
    :type     => :flag,
    :scope    => :location,
    :default  => false,
    :header   => nil
  },
  {
    :name     => 'passenger_sticky_sessions',
    :scope    => :location,
    :type     => :flag,
    :default  => false
  },
  {
    :name     => 'passenger_sticky_sessions_cookie_name',
    :scope    => :location,
    :type     => :string,
    :default  => DEFAULT_STICKY_SESSIONS_COOKIE_NAME
  },
  {
    :name     => 'passenger_sticky_sessions_cookie_attributes',
    :scope    => :location,
    :type     => :string,
    :default  => DEFAULT_STICKY_SESSIONS_COOKIE_ATTRIBUTES
  },
  {
    :name     => 'passenger_vary_turbocache_by_cookie',
    :scope    => :location,
    :type     => :string
  },


  ###### Enterprise features (placeholders in OSS) ######

  {
    :context  => [:main],
    :name     => 'passenger_fly_with',
    :scope    => :global,
    :type     => :string,
    :struct   => "NGX_HTTP_MAIN_CONF_OFFSET",
    :function => 'passenger_enterprise_only',
    :field    => nil
  },
  {
    :name     => 'passenger_max_instances',
    :scope    => :application,
    :type     => :integer,
    :function => 'passenger_enterprise_only',
    :field    => nil
  },
  {
    :name     => 'passenger_memory_limit',
    :scope    => :application,
    :type     => :integer,
    :function => 'passenger_enterprise_only',
    :field    => nil
  },
  {
    :name     => 'passenger_concurrency_model',
    :scope    => :application,
    :type     => :string,
    :function => 'passenger_enterprise_only',
    :field    => nil
  },
  {
    :name     => 'passenger_thread_count',
    :scope    => :application,
    :type     => :integer,
    :function => 'passenger_enterprise_only',
    :field    => nil
  },
  {
    :name     => 'passenger_rolling_restarts',
    :scope    => :application,
    :type     => :flag,
    :function => 'passenger_enterprise_only',
    :field    => nil
  },
  {
    :name     => 'passenger_resist_deployment_errors',
    :scope    => :application,
    :type     => :flag,
    :function => 'passenger_enterprise_only',
    :field    => nil
  },
  {
    :name     => 'passenger_max_request_time',
    :scope    => :location,
    :type     => :integer,
    :function => 'passenger_enterprise_only',
    :field    => nil
  },
  {
    :name     => 'passenger_max_request_queue_time',
    :scope    => :location,
    :type     => :integer,
    :function => 'passenger_enterprise_only',
    :field    => nil
  },
  {
    :name     => 'passenger_app_log_file',
    :scope    => :application,
    :type     => :string,
    :function => 'passenger_enterprise_only',
    :dynamic_default => 'passenger_log_file'
  },


  ###### Aliases and backwards compatibility options ######

  {
    :name      => 'passenger_debug_log_file',
    :alias_for => 'passenger_log_file'
  },
  {
    :name      => 'rails_spawn_method',
    :alias_for => 'passenger_spawn_method'
  },
  {
    :name      => 'rails_env',
    :alias_for => 'passenger_app_env'
  },
  {
    :name      => 'rack_env',
    :alias_for => 'passenger_app_env'
  },
  {
    :name      => 'rails_app_spawner_idle_time',
    :alias_for => 'passenger_max_preloader_idle_time'
  },


  ###### Deprecated/obsolete options ######

  {
    :name     => 'rails_framework_spawner_idle_time',
    :scope    => :application,
    :take     => 'NGX_CONF_TAKE1',
    :function => 'rails_framework_spawner_idle_time',
    :field    => nil
  },
  {
    :name     => 'passenger_use_global_queue',
    :scope    => :global,
    :take     => 'NGX_CONF_FLAG',
    :function => 'passenger_use_global_queue',
    :field    => nil
  },
  {
    :name     => 'passenger_analytics_log_user',
    :scope    => :global,
    :context  => [:main],
    :type     => :string,
    :function => 'passenger_obsolete_directive',
    :field    => nil
  },
  {
    :name     => 'passenger_analytics_log_group',
    :scope    => :global,
    :context  => [:main],
    :type     => :string,
    :function => 'passenger_obsolete_directive',
    :field    => nil
  },
  {
    :name     => 'union_station_gateway_address',
    :scope    => :global,
    :context  => [:main],
    :type     => :string,
    :function => 'passenger_obsolete_directive',
    :field    => nil
  },
  {
    :name     => 'union_station_gateway_port',
    :scope    => :global,
    :context  => [:main],
    :type     => :integer,
    :function => 'passenger_obsolete_directive',
    :field    => nil
  },
  {
    :name     => 'union_station_gateway_cert',
    :scope    => :global,
    :context  => [:main],
    :type     => :string,
    :function => 'passenger_obsolete_directive',
    :field    => nil
  },
  {
    :name     => 'union_station_proxy_address',
    :scope    => :global,
    :context  => [:main],
    :type     => :string,
    :function => 'passenger_obsolete_directive',
    :field    => nil
  },
  {
    :name     => 'union_station_key',
    :scope    => :application,
    :type     => :string,
    :function => 'passenger_obsolete_directive',
    :field    => nil
  },
  {
    :name     => 'union_station_support',
    :scope    => :application,
    :type     => :flag,
    :function => 'passenger_obsolete_directive',
    :field    => nil
  },
  {
    :name     => 'union_station_filter',
    :scope    => :application,
    :take     => 'NGX_CONF_TAKE1',
    :type     => :string_array,
    :function => 'passenger_obsolete_directive',
    :field    => nil
  },
]
