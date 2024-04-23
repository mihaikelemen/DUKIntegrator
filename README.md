This solution dockerize the application made by [ANAF](https://anaf.ro) to validate and generate diferent types of declarations. Inspired by this [repository](https://github.com/IncrementalCommunity/declaratii-anaf) made by [IncrementalCommunity](https://github.com/IncrementalCommunity).

This image has support for the following declarations:

- [D100](https://static.anaf.ro/static/10/Anaf/Declaratii_R/100.html)
- [D106](https://static.anaf.ro/static/10/Anaf/Declaratii_R/106.html)
- [D112](https://static.anaf.ro/static/10/Anaf/Declaratii_R/112.html)
- [D390](https://static.anaf.ro/static/10/Anaf/Declaratii_R/390.html)
- [D394](https://static.anaf.ro/static/10/Anaf/Declaratii_R/394.html)

## Usage

You can build the image by yourself using the `build.sh` tool.

The idea behind this approach you can mount `-v` your current path `$PWD` where your xml declarations are located and pass the `ID` of the declaration name. The container will output a *smart* pdf having the same name as the declaration id passed as the argument. The `/app/host` is the path to be mounted inside the image. 

Accepted enviroment variables:

- ID: declaration ID (required)
- XML: the xml file to be validated, without extension. default is `ID.xml`
- PDF: the resulting PDF file, without extension. default is `ID.pdf`

### Examples 
- Your xml file has the following naming convention `100.xml`. The resulting PDF file will follow the same rule `100.pdf`

~~~bash
docker run -e ID=100 --rm -v "$PWD:/app/host" dukintegrator:1.5
~~~

- Your xml file has a different naming `D100_1234_1232232.xml` and the resulting PDF file to be `d100_validation.pdf`

~~~bash
docker run -e ID=100 -e XML=D100_1234_1232232 -e PDF=d100_validation --rm -v "$PWD:/app/host" dukintegrator:1.5
~~~

## References

- DUKIntegrator: [https://static.anaf.ro/static/DUKIntegrator/DUKIntegrator.htm](https://static.anaf.ro/static/DUKIntegrator/DUKIntegrator.htm)
