# DUKIntegrator dockerization

This is a solution to dockerize DUKIntegrator made by ANAF. Inspired by this [repository](https://github.com/IncrementalCommunity/declaratii-anaf) made by [IncrementalCommunity](https://github.com/IncrementalCommunity)
This image only validates the declaration and on success will generate a PDF file for it.

This image has support for the following declarations (@todo add all supported declarations):

- D100
- D106
- D390
- D394

## Usage

You can build the image by yourself using the general approach of building docker images.
After this stage you can use make use of this tool by running docker image.

The idea behind this approach you can mount `-v` your current path `$PWD` where your xml declarations are stored and pass the `ID` declaration name. The container will output a 'smart' pdf having the same name as the declation id passed as the argument. The `/app/host` if the path where the current path will be mouted inside the image

~~~bash
docker run -e ID=106 --rm -v "$PWD:/app/host" dukintegrator:1.0
~~~

**IMPORTANT** make sure you name your xml file as the declaration. If you want to validate D106 (declation no. 106) you must name your xml file as `D106.xml`

## References

- DUKIntegrator: [https://static.anaf.ro/static/DUKIntegrator/DUKIntegrator.htm](https://static.anaf.ro/static/DUKIntegrator/DUKIntegrator.htm)