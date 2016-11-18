# reaktor-docker

Dockerfile for [Reaktor](https://github.com/pzim/reaktor), a modular post-receive hook designed to work with [r10k](https://github.com/puppetlabs/r10k).

## Configuration

A number of environment variables are available to configure both this image and Reaktor at runtime.

###### Required

* `REDIS_URL` - URI to your Redis instance for Resque. Defaults to: `redis://reaktor-redis:6379`
* `REAKTOR_PUPPET_MASTERS` - Comma-separated list of your Puppet masters' FQDNs
* `PUPPETFILE_GIT_URL` - The full Git SSH clone URI for your r10k control repo

###### Optional

For notifications via HipChat:

* `REAKTOR_HIPCHAT_TOKEN` - Auth token to enable posting HipChat messages. This cannot just be a notification token, as Reaktor needs to be able to get a room list.
* `REAKTOR_HIPCHAT_FROM` - User to send HipChat notifications as
* `REAKTOR_HIPCHAT_ROOM` - Name of HipChat room to send Reaktor/r10k output notifications
* `REAKTOR_HIPCHAT_URL` - Full base URL to the HipChat API, for self-hosted installations. Example: `https://hipchat.foo.bar/v1`

## OpenShift

This image has been designed, tested, and confirmed to work under OpenShift Origin/OpenShift Enterprise v3. To deploy it, import [this template](reaktor-openshift.yaml) into your project.