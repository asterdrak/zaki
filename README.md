# ZAKI README

## How to use
* manager guide [PL]: https://goo.gl/Zvsmbp
* user guide [PL]: https://goo.gl/jEb3Au



## Managing production

1. Push variables from config/application.yml to production
```sh
foo@bar:~$ bundle exec cap production setup
```
2. Puma lifecycle
```sh
foo@bar:~$ cap production puma:status
foo@bar:~$ cap production puma:start
foo@bar:~$ cap production puma:restart
foo@bar:~$ cap production puma:stop
foo@bar:~$ cap production deploy # heads up! it should be managed by CI
```