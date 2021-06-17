# e2e-test-capybara-cucumber-ruby

End to end tests with capybara and cucumber in ruby


### Configuration
* Install ruby 2.7
* Install nodejs
* Install npm
* Install allure-command    |   `npm install -g allure-commandline --save-dev`

### Installation

```
bundle install
```

### Running all tests

```
cucumber
```

### Running scenarios by tag or scenario name

```
cucumber --tags @CalcularSalarioValido              # Run scenarios that has the tag
cucumber --name="Calcular aposentadoria válido"     # Run scenarios that has the name
```


### Generate allure report

```
allure serve report/                                # open automatically on a default broser
```

The cucumber html report will also be generated at `report/report.html`