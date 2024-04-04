This solution dockerize the application made by [ANAF](https://anaf.ro) to validate and generate diferent types of declarations. Inspired by this [repository](https://github.com/IncrementalCommunity/declaratii-anaf) made by [IncrementalCommunity](https://github.com/IncrementalCommunity).

This image has support for the following declarations:

- D100
- D106
- D390
- D394

## Usage

You can build the image by yourself using the `build.sh` tool.

The idea behind this approach you can mount `-v` your current path `$PWD` where your xml declarations are located and pass the `ID` of the declaration name. The container will output a *smart* pdf having the same name as the declaration id passed as the argument. The `/app/host` is the path to be mounted inside the image.

~~~bash
docker run -e ID=106 --rm -v "$PWD:/app/host" dukintegrator:1.1
~~~

**IMPORTANT** make sure you name your xml file as the declaration. For example: if you want to validate D106 (eg. declaration no. 106) you must name your xml file as `D106.xml`

## TODO
Map all the supported declarations and add some sample files for reference

## References

- DUKIntegrator: [https://static.anaf.ro/static/DUKIntegrator/DUKIntegrator.htm](https://static.anaf.ro/static/DUKIntegrator/DUKIntegrator.htm)
