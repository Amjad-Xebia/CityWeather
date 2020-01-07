# CityWeather

## MVC-N Design Pattern
I have used MVC-N design pattern to implement this project. Responsibilities are distinctly distributed between classes.

## Generate Code Coverage Reports With Slather
Test Coverage: 13.69%

I have used [Slather](https://cocoacasts.com/how-to-generate-code-coverage-reports-in-xcode-with-slather) tool to generate code coverage report. 


To generate report use below commnad and specify path for xcworkspace and xcodeproj
```bash
$ slather coverage -s --scheme CityWeather --show path/to/XNYTimes.xcworkspace path/to/CityWeather.xcodeproj
```

