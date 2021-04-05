# About

Author: Febri Adrian
Email: febriadrian.dev@gmail.com

# How To Run Unit Test

First you need to install Mockingbird framework in your project, go to the Mockingbird Folder.
```sh
$ cd /Pods/MockingbirdFramework 
```

Then install the framework
```sh
make install-prebuilt
```

After the process complete, you need to go back to the project root directory and install the framework.

```sh
mockingbird download starter-pack
```

```sh
mockingbird install --target DotaHeroesTests --sources 'DotaHeroes'
```

Then the last thing you need to do is generate a mock.
```sh
mockingbird generate --targets 'DotaHeroes' --output 'MockingbirdMocks/DotaHeroesTests-DotaHeroesMocks.generated.swift' --disable-cache --verbose
```
