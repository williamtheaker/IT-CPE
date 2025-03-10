# Copyright (c) Facebook, Inc. and its affiliates.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Cookbook Name:: cpe_chrome
# Recipe:: default

cpe_chrome 'Configure Google Chrome' do
  only_if do
    node['cpe_chrome']['profile'].any? ||
    node['cpe_chrome']['mp']['UseMasterPreferencesFile']
  end
end

directory '/usr/local/libexec' do
  only_if { node.debian_family? }
  owner node.root_user
  group node.root_group
  mode '0755'
end

cookbook_file '/usr/local/libexec/chromium1238517workaround' do
  only_if { node.linux? }
  source 'chromium1238517workaround.py'
  owner node.root_user
  group node.root_group
  mode '0755'
end
