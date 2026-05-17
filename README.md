# Run Geb Tests on HyperExecute with TestMu AI (Formerly LambdaTest)

<p align="center">
  <a href="https://www.testmuai.com/"><img src="https://img.shields.io/badge/MADE%20BY%20TestMu%20AI-000000.svg?style=for-the-badge&labelColor=000" alt="Made by TestMu AI"></a>
  <a href="https://mvnrepository.com/artifact/org.gebish/geb-core"><img src="https://img.shields.io/maven-central/v/org.gebish/geb-core.svg?style=for-the-badge&labelColor=000000" alt="Geb version"></a>
  <a href="https://community.testmuai.com/"><img src="https://img.shields.io/badge/Join%20the%20community-blueviolet.svg?style=for-the-badge&labelColor=000000" alt="Community"></a>
</p>

## Getting Started

[TestMu AI](https://www.testmuai.com/) (Formerly LambdaTest) is the world's first full-stack AI Agentic Quality Engineering platform that empowers teams to test intelligently, smarter, and ship faster. Built for scale, it offers a full-stack testing cloud with 10K+ real devices and 3,000+ browsers. With AI-native test management, MCP servers, and agent-based automation, TestMu AI supports Selenium, Appium, Playwright, and all major frameworks.

With TestMu AI (Formerly LambdaTest), you can run Geb-Spock automation tests at scale on the HyperExecute smart test orchestration platform. This sample shows how to configure and execute Geb tests using both Matrix and Auto-Split strategies on the TestMu AI cloud.

- [Sign up on TestMu AI](https://www.testmuai.com/register/) (Formerly LambdaTest).
- Follow the [TestMu AI documentation](https://www.testmuai.com/support/docs/) (Formerly LambdaTest) for the full setup walkthrough.

HyperExecute is a smart test orchestration platform to run end-to-end Selenium tests at the fastest speed possible. HyperExecute lets you achieve an accelerated time to market by providing a test infrastructure that offers optimal speed, test orchestration, and detailed execution logs.

The overall experience helps teams test code and fix issues at a much faster pace. HyperExecute is configured using a YAML file. Instead of moving the Hub close to you, HyperExecute brings the test scripts close to the Hub!

* **HyperExecute HomePage**: https://www.testmuai.com/hyperexecute
* **TestMu AI (Formerly LambdaTest) Support**: [support@testmuai.com](mailto:support@testmuai.com)

To know more about how HyperExecute does intelligent Test Orchestration, check out the [HyperExecute Getting Started Guide](https://www.testmuai.com/support/docs/getting-started-with-hyperexecute/)

### Prerequisites

Before using HyperExecute, you have to download the HyperExecute CLI corresponding to the host OS. Along with it, you also need to export the environment variables `LT_USERNAME` and `LT_ACCESS_KEY` that are available on your [TestMu AI Profile](https://accounts.lambdatest.com/detail/profile) page.

- Java 8 or later
- Maven
- Groovy / Spock

### Download HyperExecute CLI

HyperExecute CLI is a CLI for interacting and running the tests on the HyperExecute Grid. Download the binary corresponding to your platform:

* Mac: https://downloads.lambdatest.com/hyperexecute/darwin/hyperexecute
* Linux: https://downloads.lambdatest.com/hyperexecute/linux/hyperexecute
* Windows: https://downloads.lambdatest.com/hyperexecute/windows/hyperexecute.exe

It is recommended to download the binary in the project's parent directory.

### Setup

Clone the repository:

```bash
git clone https://github.com/LambdaTest/Geb-HyperExecute-Sample.git
cd Geb-HyperExecute-Sample
```

Set your credentials as environment variables.

**macOS / Linux:**

```bash
export LT_USERNAME="YOUR_USERNAME"
export LT_ACCESS_KEY="YOUR_ACCESS_KEY"
```

**Windows:**

```bash
set LT_USERNAME="YOUR_USERNAME"
set LT_ACCESS_KEY="YOUR_ACCESS_KEY"
```

## Matrix Execution with Geb Spock Framework

Matrix-based test execution is used for running the same tests across different test (or input) combinations. The Matrix directive in HyperExecute YAML file is a `key:value` pair where value is an array of strings.

For more information about matrix multiplexing, check out the [Matrix Getting Started Guide](https://www.testmuai.com/support/docs/getting-started-with-hyperexecute/#matrix-based-build-multiplexing).

### Core

In the current example, the matrix YAML file (`hyperexecute_matrix.yaml`) contains the following configuration:

```yaml
globalTimeout: 90
testSuiteTimeout: 90
testSuiteStep: 90
```

Global timeout, testSuite timeout, and testSuiteStep timeout are set to 90 minutes.

The target platform is set to Windows. Set the `runson` key to `win` if the tests have to be executed on the Windows platform.

```yaml
runson: win
```

Geb-Spock groovy files in the `groovy` folder contain the groovy Scenario run on the HyperExecute grid. In the example, the groovy file `groovy/BingSpecPageGebSpec.groovy` runs in parallel on the basis of scenario by using the `method` field input combinations.

```yaml
matrix:
  os: [win]
  method: ["BingSpecPageGebSpec#Hypertest", "BingSpecPageGebSpec#Lamdbdatest", "BingSpecPageGebSpec#Test_Ocrchestration"]
```

The `testSuites` object contains a list of commands (presented in an array). The `run.sh` script is used to trigger each method:

```yaml
testSuites:
  - ./run.sh $method #mac
  - sh run.sh $method #win
```

### Pre Steps and Dependency Caching

Steps that must run before test execution are listed in the `pre` run step. In the example, Maven compiles the project:

```yaml
pre:
  - mvn compile
  - mvn versions:display-dependency-updates
```

HyperExecute also facilitates the provision to download the artefacts on your local machine. To download the artefacts, click on the Artefacts button corresponding to the associated TestID.

### Test Execution

The CLI option `--config` is used for providing the custom HyperExecute YAML file. Run the following command on the terminal to trigger the tests in groovy file Scenario on the HyperExecute grid:

```bash
./hyperexecute --config --verbose -i yaml/hyperexecute_matrix.yaml
```

Visit the [HyperExecute Automation Dashboard](https://automation.lambdatest.com/hyperexecute) to check the status of execution.

## Auto-Split Execution with Geb Spock Framework

Auto-split execution mechanism lets you run tests at predefined concurrency and distribute the tests over the available infrastructure. Concurrency can be achieved at different levels - file, module, test suite, test, scenario, etc.

For more information about auto-split execution, check out the [Auto-Split Getting Started Guide](https://www.testmuai.com/support/docs/getting-started-with-hyperexecute/#smart-auto-test-splitting).

### Core

Auto-split YAML file (`hyperexecute_autosplit.yaml`) in the repo contains the following configuration:

```yaml
globalTimeout: 90
testSuiteTimeout: 90
testSuiteStep: 90
```

The `runson` key determines the platform on which the tests are executed:

```yaml
runson: win
```

Auto-split is set to true:

```yaml
autosplit: true
```

`retryOnFailure` is set to true, instructing HyperExecute to retry failed commands. The retry operation is carried out till the number of retries mentioned in `maxRetries` are exhausted or the command execution results in a Pass. The concurrency is set to 2:

```yaml
retryOnFailure: true
runson: win
maxRetries: 2
```

### Pre Steps and Dependency Caching

The `testDiscovery` directive contains the command that gives details of the mode of execution, along with the command that is used for test execution. Here, we are fetching the list of groovy file scenarios that would be further executed using the `value` passed in the `testRunnerCommand`:

```yaml
testDiscovery:
  type: raw
  mode: static
  command: grep --with-filename 'def' src/test/groovy/Spec/*.groovy | sed 's/\.groovy\(.*\)def /#/g' | sed -e 's/.*\/\(.*\)(.*/\1/'

testRunnerCommand: ./run.sh $test #mac
testRunnerCommand: sh run.sh $test #win
```

Running the above command on the terminal gives a list of groovy Scenario lines that are located in the Project folder:

```
BingSpecPageGebSpec1#Hypertest
BingSpecPageGebSpec1#Lamdbdatest
BingSpecPageGebSpec1#Test_Ocrchestration
BingSpecPageGebSpec2#Hypertest
BingSpecPageGebSpec2#Lamdbdatest
BingSpecPageGebSpec2#Test_Ocrchestration
...
```

### Test Execution

Run the following command on the terminal to trigger the tests in Geb groovy files on the HyperExecute grid:

```bash
./hyperexecute --config --verbose -i yaml/.hyperexecute_matrix.yaml
```

Visit the [HyperExecute Automation Dashboard](https://automation.lambdatest.com/hyperexecute) to check the status of execution.

## Secrets Management

In case you want to use any secret keys in the YAML file, the same can be set by clicking on the **Secrets** button on the dashboard:

1. Open HyperExecute Dashboard
2. Click on Secrets
3. Add Secrets with Name as AccessKey

All you need to do is create an environment variable that uses the secret key:

```yaml
env:
  AccessKey: ${{.secrets.AccessKey}}
```

## Navigation in Automation Dashboard

HyperExecute lets you navigate from/to *Test Logs* in Automation Dashboard from/to *HyperExecute Logs*. You also get relevant Selenium test details like video, network log, commands, Exceptions & more in the Dashboard. Effortlessly navigate from the automation dashboard to HyperExecute logs (and vice-versa) to get more details of the test execution.

### Run tests

**Matrix mode:**

```bash
./hyperexecute --config --verbose -i yaml/hyperexecute_matrix.yaml
```

**Auto-split mode:**

```bash
./hyperexecute --config --verbose -i yaml/hyperexecute_autosplit.yaml
```

View results on your TestMu AI dashboard.

## Contributions

Contributions are welcome. Open an issue to discuss your idea before submitting a pull request. When reporting bugs, include your Java version, OS, and Geb version.

## TestMu AI (Formerly LambdaTest) Community

Connect with testers and developers in the [TestMu AI Community](https://community.testmuai.com/). Ask questions, share what you are building, and discuss best practices in test automation and DevOps.

## TestMu AI (Formerly LambdaTest) Certifications

Earn free [TestMu AI Certifications](https://www.testmuai.com/certifications/) for testers, developers, and QA engineers. Validate your skills in Selenium, Cypress, Playwright, Appium, Espresso and more. Industry-recognized, shareable on LinkedIn, and built by practitioners, not marketers.

## Learning Resources by TestMu AI (Formerly LambdaTest)

Learn modern testing through tutorials, guides, videos, and weekly updates:

* [TestMu AI Blog](https://www.testmuai.com/blog/)
* [TestMu AI Learning Hub](https://www.testmuai.com/learning-hub/)
* [TestMu AI on YouTube](https://www.youtube.com/@TestMuAI)
* [TestMu AI Newsletter](https://www.testmuai.com/newsletter/)

## LambdaTest is Now TestMu AI

On **January 12, 2026**, [LambdaTest evolved to TestMu AI](https://www.testmuai.com/lambdatest-is-now-testmuai/), the world's first fully autonomous **Agentic AI Quality Engineering Platform**.

Same team. Same infrastructure. Same customer accounts. All existing LambdaTest logins, scripts, capabilities, and integrations continue to work without change.

Find the new home for [LambdaTest](https://www.testmuai.com).

### How LambdaTest Evolved into TestMu AI

In 2017, we launched LambdaTest with a simple mission: make testing fast, reliable, and accessible. As LambdaTest grew, we expanded into Test Intelligence, Visual Regression Testing, Accessibility Testing, API Testing, and Performance Testing, covering the full depth of the testing lifecycle.

As software development entered the AI era, testing had to evolve, too. We rebuilt the architecture to be AI-native from the ground up, with autonomous agents that **plan, author, execute, analyze, and optimize tests** while keeping humans in the loop. The platform integrates with your repos, CI, IDEs, and terminals, continuously learning from every code change and development signal.

That evolution earned a new name: **TestMu AI**, built for an AI-first future of quality engineering. TestMu is not a new name for us. It is the name of our annual community conference, which has brought together 100,000+ quality engineers to discuss how AI would reshape testing, long before that became an industry norm.

What started as a high-performance cloud testing platform has transformed into an AI-native, multi-agent system powering a connected, end-to-end quality layer. That evolution defined a new identity: LambdaTest evolved into TestMu AI, built for an AI-first future of quality engineering.

## Support

Got a question? Email [support@testmuai.com](mailto:support@testmuai.com) or chat with us 24x7 from our chat portal.
