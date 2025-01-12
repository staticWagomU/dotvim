--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
--ref: https://zenn.dev/nazo6/articles/989d44e16b1abb
return {
    ["$schema"] = "https://json.schemastore.org/schema-catalog.json",
    version = 1,
    schemas = {
        {
            name = ".adonisrc.json",
            description = "AdonisJS configuration file",
            fileMatch = {".adonisrc.json"},
            url = "https://raw.githubusercontent.com/adonisjs/application/master/adonisrc.schema.json"
        },
        {
            name = ".aiproj.json",
            description = "Settings for project analysis by the application inspector",
            fileMatch = {".aiproj.json"},
            url = "https://json.schemastore.org/aiproj.json"
        },
        {
            name = "angular.json",
            description = "Angular configuration file",
            fileMatch = {"angular.json"},
            url = "https://raw.githubusercontent.com/angular/angular-cli/master/packages/angular/cli/lib/config/workspace-schema.json"
        },
        {
            name = ".angular-cli.json",
            description = "Angular CLI configuration file",
            fileMatch = {".angular-cli.json", "angular-cli.json"},
            url = "https://raw.githubusercontent.com/angular/angular-cli/v10.1.6/packages/angular/cli/lib/config/schema.json"
        },
        {
            name = "Ansible Role",
            description = "Ansible role task files",
            url = "https://json.schemastore.org/ansible-role-2.9.json",
            fileMatch = {"**/roles/**/tasks/*.yml", "**/roles/**/tasks/*.yaml"},
            versions = {
                ["2.0"] = "https://json.schemastore.org/ansible-role-2.0.json",
                ["2.1"] = "https://json.schemastore.org/ansible-role-2.1.json",
                ["2.2"] = "https://json.schemastore.org/ansible-role-2.2.json",
                ["2.3"] = "https://json.schemastore.org/ansible-role-2.3.json",
                ["2.4"] = "https://json.schemastore.org/ansible-role-2.4.json",
                ["2.5"] = "https://json.schemastore.org/ansible-role-2.5.json",
                ["2.6"] = "https://json.schemastore.org/ansible-role-2.6.json",
                ["2.7"] = "https://json.schemastore.org/ansible-role-2.7.json",
                ["2.9"] = "https://json.schemastore.org/ansible-role-2.9.json"
            }
        },
        {
            name = "Ansible Playbook",
            description = "Ansible playbook files",
            url = "https://json.schemastore.org/ansible-playbook.json",
            fileMatch = {"playbook.yml", "playbook.yaml"}
        },
        {
            name = "Ansible Inventory",
            description = "Ansible inventory files",
            url = "https://json.schemastore.org/ansible-inventory.json",
            fileMatch = {"inventory.yml", "inventory.yaml"}
        },
        {
            name = "Ansible Collection Galaxy",
            description = "Ansible Collection Galaxy metadata",
            url = "https://raw.githubusercontent.com/ansible-community/schemas/main/f/ansible-galaxy.json",
            fileMatch = {"galaxy.yml"}
        },
        {
            name = "apple-app-site-association",
            description = "Apple Universal Link, App Site Association",
            fileMatch = {"apple-app-site-association"},
            url = "https://json.schemastore.org/apple-app-site-association.json"
        },
        {
            name = "appsscript.json",
            description = "Google Apps Script manifest file",
            fileMatch = {"appsscript.json"},
            url = "https://json.schemastore.org/appsscript.json"
        },
        {
            name = "appsettings.json",
            description = "ASP.NET Core's configuration file",
            fileMatch = {"appsettings.json", "appsettings.*.json"},
            url = "https://json.schemastore.org/appsettings.json"
        },
        {
            name = "appveyor.yml",
            description = "AppVeyor CI configuration file",
            fileMatch = {"appveyor.yml"},
            url = "https://json.schemastore.org/appveyor.json"
        },
        {
            name = "arc.json",
            description = "A JSON schema for OpenJS Architect",
            fileMatch = {"arc.json", "arc.yml", "arc.yaml"},
            url = "https://raw.githubusercontent.com/architect/parser/v2.3.0/arc-schema.json"
        },
        {
            name = "Argo Workflows",
            description = "Argo Workflow configuration file",
            url = "https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"
        },
        {
            name = "Avro Avsc",
            description = "Avro Schema Avsc file",
            fileMatch = {"*.avsc"},
            url = "https://json.schemastore.org/avro-avsc.json"
        },
        {
            name = "Azure IoT EdgeAgent deployment",
            description = "Azure IoT EdgeAgent deployment schema",
            url = "https://json.schemastore.org/azure-iot-edgeagent-deployment-1.1.json",
            versions = {
                ["1.0"] = "https://json.schemastore.org/azure-iot-edgeagent-deployment-1.0.json",
                ["1.1"] = "https://json.schemastore.org/azure-iot-edgeagent-deployment-1.1.json"
            }
        },
        {
            name = "Azure IoT EdgeHub deployment",
            description = "Azure IoT EdgeHub deployment schema",
            url = "https://json.schemastore.org/azure-iot-edgehub-deployment-1.2.json",
            versions = {
                ["1.0"] = "https://json.schemastore.org/azure-iot-edgehub-deployment-1.0.json",
                ["1.1"] = "https://json.schemastore.org/azure-iot-edgehub-deployment-1.1.json",
                ["1.2"] = "https://json.schemastore.org/azure-iot-edgehub-deployment-1.2.json"
            }
        },
        {
            name = "Azure IoT Edge deployment",
            description = "Azure IoT Edge deployment schema",
            url = "https://json.schemastore.org/azure-iot-edge-deployment-2.0.json",
            versions = {
                ["1.0"] = "https://json.schemastore.org/azure-iot-edge-deployment-1.0.json",
                ["1.1"] = "https://json.schemastore.org/azure-iot-edge-deployment-2.0.json"
            }
        },
        {
            name = "Azure IoT Edge deployment template",
            description = "Azure IoT Edge deployment template schema",
            fileMatch = {"deployment.template.json", "deployment.*.template.json"},
            url = "https://json.schemastore.org/azure-iot-edge-deployment-template-2.0.json",
            versions = {
                ["1.0"] = "https://json.schemastore.org/azure-iot-edge-deployment-template-1.0.json",
                ["1.1"] = "https://json.schemastore.org/azure-iot-edge-deployment-template-2.0.json"
            }
        },
        {
            name = "Azure Pipelines",
            description = "Azure Pipelines YAML pipelines definition",
            fileMatch = {"azure-pipelines.yml", "azure-pipelines.yaml"},
            url = "https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/v1.174.2/service-schema.json"
        },
        {
            name = "Foxx Manifest",
            description = "ArangoDB Foxx service manifest file",
            fileMatch = {"manifest.json"},
            url = "https://json.schemastore.org/foxx-manifest.json"
        },
        {
            name = ".asmdef",
            description = "Unity 3D assembly definition file",
            fileMatch = {"*.asmdef"},
            url = "https://json.schemastore.org/asmdef.json"
        },
        {
            name = "babelrc.json",
            description = "Babel configuration file",
            fileMatch = {".babelrc", "babel.config.json"},
            url = "https://json.schemastore.org/babelrc.json"
        },
        {
            name = ".backportrc.json",
            description = "Backport configuration file",
            fileMatch = {".backportrc.json"},
            url = "https://json.schemastore.org/backportrc.json"
        },
        {
            name = "batect.yml",
            description = "Batect configuration file",
            fileMatch = {"batect.yml", "batect-bundle.yml"},
            url = "https://ide-integration.batect.dev/v1/configSchema.json"
        },
        {
            name = "bamboo-spec",
            description = "The Bamboo Specs allows you to define Bamboo configuration as code, and have corresponding plans/deployments created or updated automatically in Bamboo",
            url = "https://json.schemastore.org/bamboo-spec.json",
            fileMatch = {"bamboo.yaml", "bamboo.yml"}
        },
        {
            name = "beef-database-codegen",
            description = "Beef (Business Entity Execution Framework) database code-generation configuration.",
            url = "https://raw.githubusercontent.com/Avanade/Beef/master/tools/Beef.CodeGen.Core/Schema/database.beef.json",
            fileMatch = {"database.beef.yaml", "database.beef.yml", "database.beef.json"}
        },
        {
            name = "beef-entity-codegen",
            description = "Beef (Business Entity Execution Framework) entity code-generation configuration.",
            url = "https://raw.githubusercontent.com/Avanade/Beef/master/tools/Beef.CodeGen.Core/Schema/entity.beef.json",
            fileMatch = {
                "entity.beef.yaml",
                "entity.beef.yml",
                "entity.beef.json",
                "refdata.beef.yaml",
                "refdata.beef.yml",
                "refdata.beef.json",
                "datamodel.beef.yaml",
                "datamodel.beef.yml",
                "datamodel.beef.json"
            }
        },
        {
            name = "bitbucket-pipelines",
            description = "Bitbucket Pipelines CI/CD manifest schema",
            url = "https://bitbucket.org/atlassianlabs/atlascode/raw/main/resources/schemas/pipelines-schema.json",
            fileMatch = {"bitbucket-pipelines.yml"}
        },
        {
            name = "bitrise",
            description = "The configuration format of the Bitrise CLI. Bitrise is a collection of tools and services to help you with the development and automation of your software projects, with a main focus on mobile apps.",
            url = "https://json.schemastore.org/bitrise.json",
            fileMatch = {"bitrise.yml", "bitrise.yaml", "bitrise.json"}
        },
        {
            name = "bitrise-step",
            description = "Steps and Workflows are the heart of how Bitrise works. A Bitrise build is simply a series of Steps. Bitrise is a collection of tools and services to help you with the development and automation of your software projects, with a main focus on mobile apps.",
            url = "https://json.schemastore.org/bitrise-step.json",
            fileMatch = {"step.yml"}
        },
        {
            name = ".bootstraprc",
            description = "Webpack bootstrap-loader configuration file",
            fileMatch = {".bootstraprc"},
            url = "https://json.schemastore.org/bootstraprc.json"
        },
        {
            name = "bower.json",
            description = "Bower package description file",
            fileMatch = {"bower.json", ".bower.json"},
            url = "https://json.schemastore.org/bower.json"
        },
        {
            name = ".bowerrc",
            description = "Bower configuration file",
            fileMatch = {".bowerrc"},
            url = "https://json.schemastore.org/bowerrc.json"
        },
        {
            name = "behat.yml",
            description = "Behat configuration file",
            fileMatch = {"behat.yml", "*.behat.yml"},
            url = "https://json.schemastore.org/behat.json"
        },
        {
            name = "bozr.suite.json",
            description = "Bozr test suite file",
            fileMatch = {".suite.json", ".xsuite.json"},
            url = "https://json.schemastore.org/bozr.json"
        },
        {
            name = "browser.i18n.json",
            description = "browser.i18n messages.json translation file",
            fileMatch = {"messages.json"},
            url = "https://json.schemastore.org/browser.i18n.json"
        },
        {
            name = "bucklescript",
            description = "BuckleScript configuration file",
            fileMatch = {"bsconfig.json"},
            url = "https://raw.githubusercontent.com/rescript-lang/rescript-compiler/8.2.0/docs/docson/build-schema.json"
        },
        {
            name = "Bukkit plugin.yml",
            description = "Schema for Minecraft Bukkit plugin description files",
            fileMatch = {"plugin.yml"},
            url = "https://json.schemastore.org/bukkit-plugin.json"
        },
        {
            name = "Buildkite",
            description = "Schema for Buildkite pipeline.yml files",
            fileMatch = {
                "buildkite.yml",
                "buildkite.yaml",
                "buildkite.json",
                "buildkite.*.yml",
                "buildkite.*.yaml",
                "buildkite.*.json",
                ".buildkite/pipeline.yml",
                ".buildkite/pipeline.yaml",
                ".buildkite/pipeline.json",
                ".buildkite/pipeline.*.yml",
                ".buildkite/pipeline.*.yaml",
                ".buildkite/pipeline.*.json"
            },
            url = "https://raw.githubusercontent.com/buildkite/pipeline-schema/master/schema.json"
        },
        {
            name = ".build.yml",
            description = "Sourcehut Build Manifest",
            fileMatch = {".build.yml"},
            url = "https://json.schemastore.org/sourcehut-build-0.65.0.json",
            versions = {
                ["0.41.2"] = "https://json.schemastore.org/sourcehut-build-0.41.2.json",
                ["0.65.0"] = "https://json.schemastore.org/sourcehut-build-0.65.0.json"
            }
        },
        {
            name = "bundleconfig.json",
            description = "Schema for bundleconfig.json files",
            fileMatch = {"bundleconfig.json"},
            url = "https://json.schemastore.org/bundleconfig.json"
        },
        {
            name = "BungeeCord plugin.yml",
            description = "Schema for BungeeCord plugin description files",
            fileMatch = {"plugin.yml", "bungee.yml"},
            url = "https://json.schemastore.org/bungee-plugin.json"
        },
        {
            name = "CMake Presets",
            description = "Schema for CMake Presets",
            fileMatch = {"CMakePresets.json", "CMakeUserPresets.json"},
            url = "https://raw.githubusercontent.com/Kitware/CMake/master/Help/manual/presets/schema.json"
        },
        {
            name = "Camel YAML DSL",
            description = "Schema for Camel YAML DSL",
            fileMatch = {"*.camel.yaml", "*.camelk.yaml"},
            url = "https://raw.githubusercontent.com/apache/camel/main/dsl/camel-yaml-dsl/camel-yaml-dsl/src/generated/resources/camel-yaml-dsl.json"
        },
        {
            name = "Carafe",
            description = "Schema for Carafe compatible JavaScript Bundles",
            url = "https://carafe.fm/schema/draft-02/bundle.schema.json",
            versions = {
                ["draft-02"] = "https://carafe.fm/schema/draft-02/bundle.schema.json",
                ["draft-01"] = "https://carafe.fm/schema/draft-01/bundle.schema.json"
            }
        },
        {
            name = "CityJSON",
            description = "Schema for the representation of 3D city models",
            url = "https://raw.githubusercontent.com/cityjson/specs/1.0.1/schemas/cityjson.min.schema.json"
        },
        {
            name = "CircleCI config.yml",
            description = "Schema for CircleCI 2.0 config files",
            fileMatch = {".circleci/config.yml"},
            url = "https://json.schemastore.org/circleciconfig.json"
        },
        {
            name = ".cirrus.yml",
            description = "Cirrus CI configuration files",
            fileMatch = {".cirrus.yml"},
            url = "https://json.schemastore.org/cirrus.json"
        },
        {
            name = ".clasp.json",
            description = "Google Apps Script CLI project file",
            fileMatch = {".clasp.json"},
            url = "https://json.schemastore.org/clasp.json"
        },
        {
            name = "cloudify",
            description = "Cloudify Blueprint",
            fileMatch = {"*.cfy.yaml"},
            url = "https://json.schemastore.org/cloudify.json"
        },
        {
            name = "codemagic",
            description = "JSON schema for Codemagic CI/CD file configuration",
            fileMatch = {"codemagic.yaml", "codemagic.yml"},
            url = "https://static.codemagic.io/codemagic-schema.json"
        },
        {
            name = "JSON schema for Codecov configuration files",
            description = "Schema for codecov.yml files.",
            fileMatch = {".codecov.yml", "codecov.yml"},
            url = "https://json.schemastore.org/codecov.json"
        },
        {
            name = "JSON schema for CodeShip Pro services configuration files",
            description = "Schema for codeship-services.yml files.",
            fileMatch = {"codeship-services.yml"},
            url = "https://json.schemastore.org/codeship-services.json"
        },
        {
            name = "JSON schema for CodeShip Pro steps configuration files",
            description = "Schema for codeship-steps.yml files.",
            fileMatch = {"codeship-steps.yml"},
            url = "https://json.schemastore.org/codeship-steps.json"
        },
        {
            name = "compilerconfig.json",
            description = "Schema for compilerconfig.json files",
            fileMatch = {"compilerconfig.json"},
            url = "https://json.schemastore.org/compilerconfig.json"
        },
        {
            name = "compile_commands.json",
            description = "LLVM compilation database",
            fileMatch = {"compile_commands.json"},
            url = "https://json.schemastore.org/compile-commands.json"
        },
        {
            name = "commands.json",
            description = "Config file for Command Task Runner",
            fileMatch = {"commands.json"},
            url = "https://json.schemastore.org/commands.json"
        },
        {
            name = "cosmos.config.json",
            description = "React Cosmos configuration file",
            fileMatch = {"cosmos.config.json"},
            url = "https://json.schemastore.org/cosmos-config.json"
        },
        {
            name = "Chrome Extension",
            description = "Google Chrome extension manifest file",
            url = "https://json.schemastore.org/chrome-manifest.json"
        },
        {
            name = "chutzpah.json",
            description = "Chutzpah configuration file",
            fileMatch = {"chutzpah.json"},
            url = "https://json.schemastore.org/chutzpah.json"
        },
        {
            name = "contentmanifest.json",
            description = "Visual Studio manifest injection file",
            fileMatch = {"contentmanifest.json"},
            url = "https://json.schemastore.org/vsix-manifestinjection.json"
        },
        {
            name = "cloud-sdk-pipeline-config-schema",
            description = "SAP Cloud SDK Pipeline configuration",
            fileMatch = {"pipeline_config.yml"},
            url = "https://json.schemastore.org/cloud-sdk-pipeline-config-schema.json"
        },
        {
            name = "cloudbuild.json",
            description = "Google Cloud Build configuration file",
            fileMatch = {
                "cloudbuild.json",
                "cloudbuild.yaml",
                "cloudbuild.yml",
                "*.cloudbuild.json",
                "*.cloudbuild.yaml",
                "*.cloudbuild.yml"
            },
            url = "https://json.schemastore.org/cloudbuild.json"
        },
        {
            name = "workflows.json",
            description = "Google Cloud Workflows configuration file",
            fileMatch = {
                "workflows.json",
                "workflows.yaml",
                "workflows.yml",
                "*.workflows.json",
                "*.workflows.yaml",
                "*.workflows.yml"
            },
            url = "https://json.schemastore.org/workflows.json"
        },
        {
            name = "AWS CloudFormation",
            description = "AWS CloudFormation provides a common language for you to describe and provision all the infrastructure resources in your cloud environment.",
            fileMatch = {
                "*.cf.json",
                "*.cf.yml",
                "*.cf.yaml",
                "cloudformation.json",
                "cloudformation.yml",
                "cloudformation.yaml"
            },
            url = "https://raw.githubusercontent.com/awslabs/goformation/v4.18.2/schema/cloudformation.schema.json"
        },
        {
            name = "AWS CloudFormation Serverless Application Model (SAM)",
            description = "The AWS Serverless Application Model (AWS SAM, previously known as Project Flourish) extends AWS CloudFormation to provide a simplified way of defining the Amazon API Gateway APIs, AWS Lambda functions, and Amazon DynamoDB tables needed by your serverless application.",
            fileMatch = {
                "serverless.template",
                "*.sam.json",
                "*.sam.yml",
                "*.sam.yaml",
                "sam.json",
                "sam.yml",
                "sam.yaml"
            },
            url = "https://raw.githubusercontent.com/awslabs/goformation/v4.18.2/schema/sam.schema.json"
        },
        {
            name = "coffeelint.json",
            description = "CoffeeLint configuration file",
            fileMatch = {"coffeelint.json"},
            url = "https://json.schemastore.org/coffeelint.json"
        },
        {
            name = "composer.json",
            description = "PHP Composer configuration file",
            fileMatch = {"composer.json"},
            url = "https://json.schemastore.org/composer.json"
        },
        {
            name = "component.json",
            description = "Web component file",
            fileMatch = {"component.json"},
            url = "https://json.schemastore.org/component.json"
        },
        {
            name = "config.json",
            description = "ASP.NET project config file",
            fileMatch = {"config.json"},
            url = "https://json.schemastore.org/config.json"
        },
        {
            name = "contribute.json",
            description = "A JSON schema for open-source project contribution data by Mozilla",
            fileMatch = {"contribute.json"},
            url = "https://raw.githubusercontent.com/mozilla/contribute.json/master/schema.json"
        },
        {
            name = "cypress.json",
            description = "Cypress.io test runner configuration file",
            fileMatch = {"cypress.json"},
            url = "https://on.cypress.io/cypress.schema.json"
        },
        {
            name = ".creatomic",
            description = "A config for Atomic Design 4 React generator",
            fileMatch = {".creatomic"},
            url = "https://json.schemastore.org/creatomic.json"
        },
        {
            name = "cspell",
            description = "JSON schema for cspell configuration file",
            fileMatch = {".cspell.json", "cspell.json", "cSpell.json"},
            url = "https://raw.githubusercontent.com/streetsidesoftware/cspell/cspell4/cspell.schema.json"
        },
        {
            name = ".csscomb.json",
            description = "A JSON schema CSS Comb's configuration file",
            fileMatch = {".csscomb.json"},
            url = "https://json.schemastore.org/csscomb.json"
        },
        {
            name = ".csslintrc",
            description = "A JSON schema CSS Lint's configuration file",
            fileMatch = {".csslintrc"},
            url = "https://json.schemastore.org/csslintrc.json"
        },
        {
            name = "Dart build configuration",
            description = "Configuration for Dart's build system",
            url = "https://json.schemastore.org/dart-build.json"
        },
        {
            name = "Dart test config",
            description = "Configuration for Dart's test package",
            fileMatch = {"dart_test.yaml"},
            url = "https://json.schemastore.org/dart-test.json"
        },
        {
            name = "datalogic-scan2deploy-android",
            description = "Datalogic Scan2Deploy Android file",
            fileMatch = {".dla.json"},
            url = "https://json.schemastore.org/datalogic-scan2deploy-android.json"
        },
        {
            name = "datalogic-scan2deploy-ce",
            description = "Datalogic Scan2Deploy CE file",
            fileMatch = {".dlc.json"},
            url = "https://json.schemastore.org/datalogic-scan2deploy-ce.json"
        },
        {
            name = "debugsettings.json",
            description = "A JSON schema for the ASP.NET DebugSettings.json files",
            fileMatch = {"debugsettings.json"},
            url = "https://json.schemastore.org/debugsettings.json"
        },
        {
            name = "dependabot.json",
            description = "A JSON schema for the Dependabot config.yml files",
            fileMatch = {".dependabot/config.yml"},
            url = "https://json.schemastore.org/dependabot.json"
        },
        {
            name = "dependabot-v2.json",
            description = "A JSON schema for the Github Action's dependabot.yml files",
            fileMatch = {".github/dependabot.yml"},
            url = "https://json.schemastore.org/dependabot-2.0.json"
        },
        {
            name = "Deployer Recipe",
            description = "A JSON schema for Deployer yaml recipes",
            fileMatch = {"deploy.yaml", "deploy.yml"},
            url = "https://raw.githubusercontent.com/deployphp/deployer/master/src/schema.json"
        },
        {
            name = "detekt.yml",
            description = "Detekt Configuration File schema",
            fileMatch = {"detekt.yml", "detekt.yaml"},
            url = "https://json.schemastore.org/detekt.json"
        },
        {
            name = "docfx.json",
            description = "A JSON schema for DocFx configuraton files",
            fileMatch = {"docfx.json"},
            url = "https://json.schemastore.org/docfx.json"
        },
        {
            name = "Dolittle Artifacts",
            description = "A JSON schema for a Dolittle bounded context's artifacts",
            fileMatch = {".dolittle/artifacts.json"},
            url = "https://raw.githubusercontent.com/dolittle/DotNET.SDK/v5.0.0/Schemas/Artifacts.Configuration/artifacts.json"
        },
        {
            name = "Dolittle Bounded Context Configuration",
            description = "A JSON schema for Dolittle application's bounded context configuration",
            fileMatch = {"bounded-context.json"},
            url = "https://raw.githubusercontent.com/dolittle/Runtime/v5.1.1/Schemas/Applications.Configuration/bounded-context.json"
        },
        {
            name = "Dolittle Event Horizons Configuration",
            description = "A JSON schema for a Dolittle bounded context's event horizon configurations",
            fileMatch = {".dolittle/event-horizons.json"},
            url = "https://raw.githubusercontent.com/dolittle/Runtime/v5.1.1/Schemas/Events/event-horizons.json"
        },
        {
            name = "Dolittle Resources Configuration",
            description = "A JSON schema for a Dolittle bounded context's resource configurations",
            fileMatch = {".dolittle/resources.json"},
            url = "https://raw.githubusercontent.com/dolittle/DotNET.Fundamentals/v5.1.0/Schemas/ResourceTypes.Configuration/resources.json"
        },
        {
            name = "Dolittle Server Configuration",
            description = "A JSON schema for a Dolittle bounded context's event horizon's interaction server configuration",
            fileMatch = {".dolittle/server.json"},
            url = "https://raw.githubusercontent.com/dolittle/Runtime/v5.1.1/Schemas/Server/server.json"
        },
        {
            name = "Dolittle Tenants Configuration",
            description = "A JSON schema for a Dolittle bounded context's tenant configuration",
            fileMatch = {".dolittle/tenants.json"},
            url = "https://raw.githubusercontent.com/dolittle/Runtime/v5.1.1/Schemas/Tenancy/tenants.json"
        },
        {
            name = "Dolittle Tenant Map Configuration",
            description = "A JSON schema for a Dolittle bounded context's tenant mapping configurations",
            fileMatch = {".dolittle/tenant-map.json"},
            url = "https://raw.githubusercontent.com/dolittle/DotNET.Fundamentals/master/Schemas/Tenancy.Configuration/tenant-map.json"
        },
        {
            name = "Dolittle Topology",
            description = "A JSON schema for a Dolittle bounded context's topology",
            fileMatch = {".dolittle/topology.json"},
            url = "https://raw.githubusercontent.com/dolittle/DotNET.SDK/master/Schemas/Applications.Configuration/topology.json"
        },
        {
            name = "dotnetcli.host.json",
            description = "JSON schema for .NET CLI template host files",
            fileMatch = {"dotnetcli.host.json"},
            url = "https://json.schemastore.org/dotnetcli.host.json"
        },
        {
            name = "drone.json",
            description = "Drone CI configuration file",
            fileMatch = {".drone.yml"},
            url = "https://json.schemastore.org/drone.json"
        },
        {
            name = "Drush site aliases",
            description = "JSON Schema for Drush 9 site aliases file",
            fileMatch = {"sites/*.site.yml"},
            url = "https://json.schemastore.org/drush.site.yml.json"
        },
        {
            name = "dss-2.0.0.json",
            description = "Digital Signature Service Core Protocols, Elements, and Bindings Version 2.0",
            url = "https://json.schemastore.org/dss-2.0.0.json"
        },
        {
            name = "dvc.yaml",
            description = "JSON Schema for dvc.yaml file",
            fileMatch = {"dvc.yaml"},
            url = "https://raw.githubusercontent.com/iterative/dvcyaml-schema/master/schema.json"
        },
        {
            name = "Eclipse Che Devfile",
            description = "JSON schema for Eclipse Che Devfiles",
            url = "https://raw.githubusercontent.com/eclipse/che/7.19.2/wsmaster/che-core-api-workspace/src/main/resources/schema/1.0.0/devfile.json",
            fileMatch = {"devfile.yaml", ".devfile.yaml"}
        },
        {
            name = "ecosystem.json",
            description = "pm2 ecosystem config file",
            fileMatch = {"ecosystem.json", "ecosystem.yml", "ecosystem.yaml"},
            url = "https://json.schemastore.org/pm2-ecosystem.json"
        },
        {
            name = ".esmrc.json",
            description = "Configuration files for the esm module/package in Node.js",
            fileMatch = {".esmrc", ".esmrc.json", ".esmrc.js", ".esmrc.cjs", ".esmrc.mjs"},
            url = "https://json.schemastore.org/esmrc.json"
        },
        {
            name = "Esquio",
            description = "JSON schema for Esquio configuration files",
            url = "https://json.schemastore.org/esquio.json"
        },
        {
            name = "epr-manifest.json",
            description = "Entry Point Regulation manifest file",
            fileMatch = {"epr-manifest.json"},
            url = "https://json.schemastore.org/epr-manifest.json"
        },
        {
            name = "electron-builder configuration file.",
            description = "JSON schema for electron-build configuration file.",
            fileMatch = {"electron-builder.json"},
            url = "https://json.schemastore.org/electron-builder.json"
        },
        {
            name = "evcc.yaml",
            description = "JSON schema for evcc configuration file.",
            fileMatch = {"evcc*.yaml"},
            url = "https://raw.githubusercontent.com/andig/evcc/master/schema.json"
        },
        {
            name = "Expo SDK",
            description = "JSON schema for Expo SDK app manifest",
            fileMatch = {"app.json"},
            url = "https://json.schemastore.org/expo-40.0.0.json",
            versions = {
                ["37.0.0"] = "https://json.schemastore.org/expo-37.0.0.json",
                ["38.0.0"] = "https://json.schemastore.org/expo-38.0.0.json",
                ["39.0.0"] = "https://json.schemastore.org/expo-39.0.0.json",
                ["40.0.0"] = "https://json.schemastore.org/expo-40.0.0.json"
            }
        },
        {
            name = ".eslintrc",
            description = "JSON schema for ESLint configuration files",
            fileMatch = {".eslintrc", ".eslintrc.json", ".eslintrc.yml", ".eslintrc.yaml"},
            url = "https://json.schemastore.org/eslintrc.json"
        },
        {
            name = "Facets - FSDL - Application",
            description = "Facets Stack Definition Language for Applications",
            fileMatch = {"**/application/instances/*.json"},
            url = "https://www.facets.cloud/assets/fsdl/application.schema.json"
        },
        {
            name = "fabric.mod.json",
            description = "Metadata file used by the Fabric mod loader",
            fileMatch = {"fabric.mod.json"},
            url = "https://json.schemastore.org/fabric.mod.json"
        },
        {
            name = ".ffizer.yaml",
            description = "JSON schema for ffizer template configuration files",
            fileMatch = {".ffizer.yaml"},
            url = "https://ffizer.github.io/ffizer/ffizer.schema.json"
        },
        {
            name = "Foundry VTT - Manifest",
            description = "JSON schema for Foundry VTT system.json and module.json files.",
            fileMatch = {"system.json", "module.json"},
            url = "https://gitlab.com/-/snippets/2062623/raw/master/foundryvtt_manifest_schema.json"
        },
        {
            name = "Foundry VTT - Template",
            description = "JSON schema for Foundry VTT template.json files.",
            fileMatch = {"template.json"},
            url = "https://gitlab.com/-/snippets/2062623/raw/master/foundryvtt_template_schema.json"
        },
        {
            name = "function.json",
            description = "JSON schema for Azure Functions function.json files",
            fileMatch = {"function.json"},
            url = "https://json.schemastore.org/function.json"
        },
        {
            name = "geojson.json",
            description = "GeoJSON format for representing geographic data.",
            url = "https://json.schemastore.org/geojson.json"
        },
        {
            name = "GitVersion",
            description = "The output from the GitVersion tool",
            fileMatch = {"gitversion.json"},
            url = "https://json.schemastore.org/gitversion.json"
        },
        {
            name = "GitHub Action",
            description = "YAML schema for GitHub Actions",
            fileMatch = {"action.yml", "action.yaml"},
            url = "https://json.schemastore.org/github-action.json"
        },
        {
            name = "GitHub Funding",
            description = "YAML schema for GitHub Funding",
            fileMatch = {".github/FUNDING.yml", ".github/funding.yml", ".github/funding.yaml"},
            url = "https://json.schemastore.org/github-funding.json"
        },
        {
            name = "GitHub Workflow",
            description = "YAML schema for GitHub Workflow",
            fileMatch = {".github/workflows/**.yml", ".github/workflows/**.yaml"},
            url = "https://json.schemastore.org/github-workflow.json"
        },
        {
            name = "gitlab-ci",
            description = "JSON schema for configuring Gitlab CI",
            fileMatch = {"*.gitlab-ci.yml"},
            url = "https://json.schemastore.org/gitlab-ci.json"
        },
        {
            name = "Gitpod Configuration",
            description = "JSON schema for configuring Gitpod.io",
            fileMatch = {".gitpod.yml"},
            url = "https://gitpod.io/schemas/gitpod-schema.json"
        },
        {
            name = "global.json",
            description = "ASP.NET global configuration file",
            fileMatch = {"global.json"},
            url = "https://json.schemastore.org/global.json"
        },
        {
            name = "golangci-lint Configuration",
            description = "golangci-lint configuration file",
            fileMatch = {".golangci.yml", ".golangci.yaml", ".golangci.toml", ".golangci.json"},
            url = "https://json.schemastore.org/golangci-lint.json"
        },
        {
            name = "Grafana 5.x Dashboard",
            description = "JSON Schema for Grafana 5.x Dashboards",
            url = "https://json.schemastore.org/grafana-dashboard-5.x.json"
        },
        {
            name = "GraphQL Mesh",
            description = "JSON Schema for GraphQL Mesh config file",
            url = "https://unpkg.com/@graphql-mesh/types/config-schema.json",
            fileMatch = {
                ".meshrc.yml",
                ".meshrc.yaml",
                ".meshrc.json",
                ".meshrc.js",
                ".graphql-mesh.yaml",
                ".graphql-mesh.yml"
            }
        },
        {
            name = "GraphQL Config",
            description = "JSON Schema for GraphQL Config config file",
            url = "https://unpkg.com/graphql-config/config-schema.json",
            fileMatch = {
                "graphql.config.json",
                "graphql.config.js",
                "graphql.config.yaml",
                "graphql.config.yml",
                ".graphqlrc",
                ".graphqlrc.json",
                ".graphqlrc.yaml",
                ".graphqlrc.yml",
                ".graphqlrc.js"
            }
        },
        {
            name = "GraphQL Code Generator",
            description = "JSON Schema for GraphQL Code Generator config file",
            url = "https://www.graphql-code-generator.com/config.schema.json",
            fileMatch = {
                "codegen.yml",
                "codegen.yaml",
                "codegen.json",
                "codegen.js",
                ".codegen.yml",
                ".codegen.yaml",
                ".codegen.json",
                ".codegen.js"
            }
        },
        {
            name = "Grunt copy task",
            description = "Grunt copy task configuration file",
            fileMatch = {"copy.json"},
            url = "https://json.schemastore.org/grunt-copy-task.json"
        },
        {
            name = "Grunt clean task",
            description = "Grunt clean task configuration file",
            fileMatch = {"clean.json"},
            url = "https://json.schemastore.org/grunt-clean-task.json"
        },
        {
            name = "Grunt cssmin task",
            description = "Grunt cssmin task configuration file",
            fileMatch = {"cssmin.json"},
            url = "https://json.schemastore.org/grunt-cssmin-task.json"
        },
        {
            name = "Grunt JSHint task",
            description = "Grunt JSHint task configuration file",
            fileMatch = {"jshint.json"},
            url = "https://json.schemastore.org/grunt-jshint-task.json"
        },
        {
            name = "Grunt Watch task",
            description = "Grunt Watch task configuration file",
            fileMatch = {"watch.json"},
            url = "https://json.schemastore.org/grunt-watch-task.json"
        },
        {
            name = "Grunt base task",
            description = "Schema for standard Grunt tasks",
            fileMatch = {"grunt/*.json", "*-tasks.json"},
            url = "https://json.schemastore.org/grunt-task.json"
        },
        {
            name = "haxelib.json",
            description = "Haxelib manifest",
            fileMatch = {"haxelib.json"},
            url = "https://json.schemastore.org/haxelib.json"
        },
        {
            name = "Hayson",
            description = "Project Haystack data",
            fileMatch = {"*.hayson.json", "*.hayson.yaml", "*.hayson.yml"},
            url = "https://raw.githubusercontent.com/j2inn/hayson/master/hayson-json-schema.json"
        },
        {
            name = "host.json",
            description = "JSON schema for Azure Functions host.json files",
            fileMatch = {"host.json"},
            url = "https://json.schemastore.org/host.json"
        },
        {
            name = "host-meta.json",
            description = "Schema for host-meta JDR files",
            fileMatch = {"host-meta.json"},
            url = "https://json.schemastore.org/host-meta.json"
        },
        {
            name = ".htmlhintrc",
            description = "HTML Hint configuration file",
            fileMatch = {".htmlhintrc"},
            url = "https://json.schemastore.org/htmlhint.json"
        },
        {
            name = "hydra.yml",
            description = "ORY Hydra configuration file",
            fileMatch = {"hydra.json", "hydra.yml", "hydra.yaml", "hydra.toml"},
            url = "https://raw.githubusercontent.com/ory/hydra/v1.8.5/.schema/version.schema.json"
        },
        {
            name = "imageoptimizer.json",
            description = "Schema for imageoptimizer.json files",
            fileMatch = {"imageoptimizer.json"},
            url = "https://json.schemastore.org/imageoptimizer.json"
        },
        {
            name = "ioBroker JSON UI",
            description = "Schema for ioBroker JSON-based admin user interfaces - config, custom and tabs",
            fileMatch = {"jsonConfig.json", "jsonCustom.json", "jsonTab.json"},
            url = "https://raw.githubusercontent.com/ioBroker/adapter-react/master/schemas/jsonConfig.json"
        },
        {
            name = "ioBroker Package manifest",
            description = "Schema for ioBroker adapters io-package file",
            fileMatch = {"io-package.json"},
            url = "https://json.schemastore.org/io-package.json"
        },
        {
            name = "Jekyll configuration",
            description = "Schema for Jekyll _config.yml",
            fileMatch = {"_config.yml"},
            url = "https://json.schemastore.org/jekyll.json"
        },
        {
            name = "Jenkins X Pipelines",
            description = "Jenkins X Pipeline YAML configuration files",
            fileMatch = {"jenkins-x*.yml"},
            url = "https://jenkins-x.io/schemas/jx-schema.json"
        },
        {
            name = "Jenkins X Requirements",
            description = "Jenkins X Requirements YAML configuration file",
            fileMatch = {"jx-requirements.yml"},
            url = "https://jenkins-x.io/schemas/jx-requirements.json"
        },
        {
            name = "JFrog File Spec",
            description = "JFrog File Spec schema definition",
            fileMatch = {"**/filespecs/*.json", "*filespec*.json", "*.filespec"},
            url = "https://raw.githubusercontent.com/jfrog/jfrog-cli/master/schema/filespec-schema.json"
        },
        {
            name = "Jovo Language Models",
            description = "JSON Schema for Jovo language Models (https://www.jovo.tech/docs/model)",
            url = "https://json.schemastore.org/jovo-language-model.json"
        },
        {
            name = ".jsbeautifyrc",
            description = "js-beautify configuration file",
            fileMatch = {".jsbeautifyrc"},
            url = "https://json.schemastore.org/jsbeautifyrc.json"
        },
        {
            name = ".jsbeautifyrc-nested",
            description = "js-beautify configuration file allowing nested `js`, `css`, and `html` attributes",
            fileMatch = {".jsbeautifyrc"},
            url = "https://json.schemastore.org/jsbeautifyrc-nested.json"
        },
        {
            name = ".jscsrc",
            description = "JSCS configuration file",
            fileMatch = {".jscsrc", "jscsrc.json"},
            url = "https://json.schemastore.org/jscsrc.json"
        },
        {
            name = ".jshintrc",
            description = "JSHint configuration file",
            fileMatch = {".jshintrc"},
            url = "https://json.schemastore.org/jshintrc.json"
        },
        {
            name = ".jsinspectrc",
            description = "JSInspect configuration file",
            fileMatch = {".jsinspectrc"},
            url = "https://json.schemastore.org/jsinspectrc.json"
        },
        {
            name = "JSON-API",
            description = "JSON API document",
            fileMatch = {"*.schema.json"},
            url = "https://jsonapi.org/schema"
        },
        {
            name = "JSON Document Transform",
            description = "JSON Document Transofrm",
            url = "https://json.schemastore.org/jdt.json"
        },
        {
            name = "JSON Feed",
            description = "JSON schema for the JSON Feed format",
            fileMatch = {"feed.json"},
            url = "https://json.schemastore.org/feed.json",
            versions = {
                ["1"] = "https://json.schemastore.org/feed-1.json",
                ["1.1"] = "https://json.schemastore.org/feed.json"
            }
        },
        {
            name = "*.jsonld",
            description = "JSON Linked Data files",
            fileMatch = {"*.jsonld"},
            url = "https://json.schemastore.org/jsonld.json"
        },
        {
            name = "JSONPatch",
            description = "JSONPatch files",
            fileMatch = {"*.patch"},
            url = "https://json.schemastore.org/json-patch.json"
        },
        {
            name = "jsconfig.json",
            description = "JavaScript project configuration file",
            fileMatch = {"jsconfig.json"},
            url = "https://json.schemastore.org/jsconfig.json"
        },
        {
            name = "k3d.yaml",
            description = "k3d configuration file",
            fileMatch = {"k3d.yaml", "k3d.yml", ".k3d.yml", ".k3d.yaml", "*.k3d.yaml", "*.k3d.yml"},
            url = "https://raw.githubusercontent.com/rancher/k3d/main/pkg/config/v1alpha2/schema.json",
            versions = {v1alpha2 = "https://raw.githubusercontent.com/rancher/k3d/main/pkg/config/v1alpha2/schema.json"}
        },
        {
            name = "keto.yml",
            description = "ORY Keto configuration file",
            fileMatch = {"keto.json", "keto.yml", "keto.yaml", "keto.toml"},
            url = "https://raw.githubusercontent.com/ory/keto/master/.schema/config.schema.json"
        },
        {
            name = "kustomization.yaml",
            description = "Kubernetes native configuration management",
            fileMatch = {"kustomization.yaml", "kustomization.yml"},
            url = "https://json.schemastore.org/kustomization.json"
        },
        {
            name = "launchsettings.json",
            description = "A JSON schema for the ASP.NET LaunchSettings.json files",
            fileMatch = {"launchsettings.json"},
            url = "https://json.schemastore.org/launchsettings.json"
        },
        {
            name = "lerna.json",
            description = "A JSON schema for lerna.json files",
            fileMatch = {"lerna.json"},
            url = "https://json.schemastore.org/lerna.json"
        },
        {
            name = "libman.json",
            description = "JSON schema for client-side library config files",
            fileMatch = {"libman.json"},
            url = "https://json.schemastore.org/libman.json"
        },
        {
            name = "local.settings.json",
            description = "JSON schema for Azure Functions local.settings.json files",
            fileMatch = {"local.settings.json"},
            url = "https://json.schemastore.org/local.settings.json"
        },
        {
            name = "localazy.json",
            description = "JSON schema for Localazy CLI configuration file. More info at https://localazy.com/docs/cli",
            fileMatch = {"localazy.json"},
            url = "https://raw.githubusercontent.com/localazy/cli-schema/master/localazy.json"
        },
        {
            name = "lsdlschema.json",
            description = "JSON schema for Linguistic Schema Definition Language files",
            fileMatch = {"*.lsdl.yaml", "*.lsdl.json"},
            url = "https://json.schemastore.org/lsdlschema.json"
        },
        {
            name = "Mega-Linter configuration",
            description = "JSON schema for Mega-Linter configuration file (for Mega-Linter users)",
            fileMatch = {".mega-linter.yml", "*.mega-linter-config.yml"},
            url = "https://raw.githubusercontent.com/nvuillam/mega-linter/master/megalinter/descriptors/schemas/megalinter-configuration.jsonschema.json"
        },
        {
            name = "Mega-Linter descriptor",
            description = "JSON schema for Mega-Linter descriptor files (for Mega-Linter contributors)",
            fileMatch = {"*.megalinter-descriptor.yml"},
            url = "https://raw.githubusercontent.com/nvuillam/mega-linter/master/megalinter/descriptors/schemas/megalinter-descriptor.jsonschema.json"
        },
        {
            name = "Microsoft Band Web Tile",
            description = "Microsoft Band Web Tile manifest file",
            url = "https://json.schemastore.org/band-manifest.json"
        },
        {
            name = "mimetypes.json",
            description = "JSON Schema for mime type collections",
            fileMatch = {"mimetypes.json"},
            url = "https://json.schemastore.org/mimetypes.json"
        },
        {
            name = ".mocharc",
            description = "JSON schema for MochaJS configuration files",
            fileMatch = {".mocharc.json", ".mocharc.jsonc", ".mocharc.yml", ".mocharc.yaml"},
            url = "https://json.schemastore.org/mocharc.json"
        },
        {
            name = ".modernizrrc",
            description = "Webpack modernizr-loader configuration file",
            fileMatch = {".modernizrrc"},
            url = "https://json.schemastore.org/modernizrrc.json"
        },
        {
            name = "mycode.json",
            description = "JSON schema for mycode.js files",
            fileMatch = {"mycode.json"},
            url = "https://json.schemastore.org/mycode.json"
        },
        {
            name = "Netlify config schema",
            description = "This schema describes the YAML config that Netlify uses",
            fileMatch = {"admin/config*.yml"},
            url = "https://json.schemastore.org/netlify.json"
        },
        {
            name = "Nightwatch.js",
            description = "nightwatch.js schema",
            fileMatch = {"nightwatch.json"},
            url = "https://json.schemastore.org/nightwatch.json"
        },
        {
            name = "ninjs (News in JSON)",
            description = "A JSON Schema for ninjs by the IPTC. News and publishing information. See https://iptc.org/standards/ninjs/",
            url = "https://json.schemastore.org/ninjs-1.3.json",
            versions = {
                ["1.3"] = "https://json.schemastore.org/ninjs-1.3.json",
                ["1.2"] = "https://json.schemastore.org/ninjs-1.2.json",
                ["1.1"] = "https://json.schemastore.org/ninjs-1.1.json",
                ["1.0"] = "https://json.schemastore.org/ninjs-1.0.json"
            }
        },
        {
            name = "nest-cli",
            description = "A progressive Node.js framework for building efficient and scalable server-side applications 🚀.",
            url = "https://json.schemastore.org/nest-cli.json",
            fileMatch = {".nestcli.json", ".nest-cli.json", "nest-cli.json", "nest.json"}
        },
        {
            name = "nlu.json",
            description = "Schema for NPM-Link-Up",
            fileMatch = {"nlu.json", ".nlu.json"},
            url = "https://raw.githubusercontent.com/oresoftware/npm-link-up/master/assets/nlu.schema.json"
        },
        {
            name = ".nodehawkrc",
            description = "JSON schema for .nodehawkrc configuration files.",
            url = "https://json.schemastore.org/nodehawkrc.json",
            fileMatch = {".nodehawkrc"}
        },
        {
            name = "nodemon.json",
            description = "JSON schema for nodemon.json configuration files.",
            url = "https://json.schemastore.org/nodemon.json",
            fileMatch = {"nodemon.json"}
        },
        {
            name = ".npmpackagejsonlintrc",
            description = "Configuration file for npm-package-json-lint",
            fileMatch = {".npmpackagejsonlintrc", "npmpackagejsonlintrc.json", ".npmpackagejsonlintrc.json"},
            url = "https://json.schemastore.org/npmpackagejsonlintrc.json"
        },
        {
            name = "nuget-project.json",
            description = "JSON schema for NuGet project.json files.",
            url = "https://json.schemastore.org/nuget-project.json",
            versions = {["3.3.0"] = "https://json.schemastore.org/nuget-project-3.3.0.json"}
        },
        {
            name = "nswag.json",
            description = "JSON schema for nswag configuration",
            url = "https://json.schemastore.org/nswag.json",
            fileMatch = {"nswag.json"}
        },
        {
            name = "oathkeeper.yml",
            description = "ORY Oathkeeper configuration file",
            fileMatch = {"oathkeeper.json", "oathkeeper.yml", "oathkeeper.yaml", "oathkeeper.toml"},
            url = "https://raw.githubusercontent.com/ory/oathkeeper/master/.schemas/config.schema.json"
        },
        {
            name = "ocelot.json",
            description = "JSON schema for the Ocelot Api Gateway.",
            fileMatch = {"ocelot.json"},
            url = "https://json.schemastore.org/ocelot.json"
        },
        {
            name = "omnisharp.json",
            description = "Omnisharp Configuration file",
            fileMatch = {"omnisharp.json"},
            url = "https://json.schemastore.org/omnisharp.json"
        },
        {
            name = "openapi.json",
            description = "A JSON schema for Open API documentation files",
            fileMatch = {"openapi.json", "openapi.yml", "openapi.yaml"},
            url = "https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json",
            versions = {
                ["3.0"] = "https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.0/schema.json",
                ["3.1"] = "https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"
            }
        },
        {
            name = "openfin.json",
            description = "OpenFin application configuration file",
            url = "https://json.schemastore.org/openfin.json"
        },
        {
            name = "kratos.yml",
            description = "ORY Kratos configuration file",
            fileMatch = {"kratos.json", "kratos.yml", "kratos.yaml"},
            url = "https://raw.githubusercontent.com/ory/kratos/master/.schema/version.schema.json"
        },
        {
            name = "package.json",
            description = "NPM configuration file",
            fileMatch = {"package.json"},
            url = "https://json.schemastore.org/package.json"
        },
        {
            name = "package.manifest",
            description = "Umbraco package configuration file",
            fileMatch = {"package.manifest"},
            url = "https://json.schemastore.org/package.manifest.json",
            versions = {
                ["8.0.0"] = "https://json.schemastore.org/package.manifest-8.0.0.json",
                ["7.0.0"] = "https://json.schemastore.org/package.manifest-7.0.0.json"
            }
        },
        {
            name = "Packer",
            description = "Packer template JSON configuration",
            fileMatch = {"packer.json"},
            url = "https://json.schemastore.org/packer.json"
        },
        {
            name = "pgap_yaml_input_reader",
            description = "NCBI Prokaryotic Genome Annotation Pipeline (PGAP) input metadata (submol) JSON/YAML configuration file",
            fileMatch = {"submol*.json", "submol*.yml", "submol*.yaml"},
            url = "https://json.schemastore.org/pgap_yaml_input_reader.json"
        },
        {
            name = "pattern.json",
            description = "Patternplate pattern manifest file",
            fileMatch = {"pattern.json"},
            url = "https://json.schemastore.org/pattern.json"
        },
        {
            name = ".pmbot.yml",
            description = "Pmbot configuration file",
            fileMatch = {".pmbot.yml"},
            url = "https://raw.githubusercontent.com/pmbot-io/config/master/pmbot.yml.schema.json"
        },
        {
            name = "PocketMine plugin.yml",
            description = "PocketMine plugin manifest file",
            fileMatch = {"plugin.yml"},
            url = "https://json.schemastore.org/pocketmine-plugin.json"
        },
        {
            name = ".pre-commit-config.yml",
            description = "pre-commit configuration file",
            fileMatch = {".pre-commit-config.yml", ".pre-commit-config.yaml"},
            url = "https://json.schemastore.org/pre-commit-config.json"
        },
        {
            name = ".phraseapp.yml",
            description = "PhraseApp configuration file",
            fileMatch = {".phraseapp.yml"},
            url = "https://json.schemastore.org/phraseapp.json"
        },
        {
            name = "prettierrc.json",
            description = ".prettierrc configuration file",
            fileMatch = {".prettierrc", ".prettierrc.json", ".prettierrc.yml", ".prettierrc.yaml"},
            url = "https://json.schemastore.org/prettierrc.json",
            versions = {["1.8.2"] = "https://json.schemastore.org/prettierrc-1.8.2.json"}
        },
        {
            name = "prisma.yml",
            description = "prisma.yml service definition file",
            fileMatch = {"prisma.yml"},
            url = "https://json.schemastore.org/prisma.json"
        },
        {
            name = "project.json",
            description = "ASP.NET vNext project configuration file",
            fileMatch = {"project.json"},
            url = "https://json.schemastore.org/project.json",
            versions = {
                ["1.0.0-beta3"] = "https://json.schemastore.org/project-1.0.0-beta3.json",
                ["1.0.0-beta4"] = "https://json.schemastore.org/project-1.0.0-beta4.json",
                ["1.0.0-beta5"] = "https://json.schemastore.org/project-1.0.0-beta5.json",
                ["1.0.0-beta6"] = "https://json.schemastore.org/project-1.0.0-beta6.json",
                ["1.0.0-beta8"] = "https://json.schemastore.org/project-1.0.0-beta8.json",
                ["1.0.0-rc1"] = "https://json.schemastore.org/project-1.0.0-rc1.json",
                ["1.0.0-rc1-update1"] = "https://json.schemastore.org/project-1.0.0-rc1.json",
                ["1.0.0-rc2"] = "https://json.schemastore.org/project-1.0.0-rc2.json"
            }
        },
        {
            name = "project-1.0.0-beta3.json",
            description = "ASP.NET vNext project configuration file",
            url = "https://json.schemastore.org/project-1.0.0-beta3.json"
        },
        {
            name = "project-1.0.0-beta4.json",
            description = "ASP.NET vNext project configuration file",
            url = "https://json.schemastore.org/project-1.0.0-beta4.json"
        },
        {
            name = "project-1.0.0-beta5.json",
            description = "ASP.NET vNext project configuration file",
            url = "https://json.schemastore.org/project-1.0.0-beta5.json"
        },
        {
            name = "project-1.0.0-beta6.json",
            description = "ASP.NET vNext project configuration file",
            url = "https://json.schemastore.org/project-1.0.0-beta6.json"
        },
        {
            name = "project-1.0.0-beta8.json",
            description = "ASP.NET vNext project configuration file",
            url = "https://json.schemastore.org/project-1.0.0-beta8.json"
        },
        {
            name = "project-1.0.0-rc1.json",
            description = "ASP.NET vNext project configuration file",
            url = "https://json.schemastore.org/project-1.0.0-rc1.json"
        },
        {
            name = "project-1.0.0-rc2.json",
            description = ".NET Core project configuration file",
            url = "https://json.schemastore.org/project-1.0.0-rc2.json"
        },
        {
            name = "prometheus.json",
            description = "Prometheus configuration file",
            fileMatch = {"prometheus.yml"},
            url = "https://json.schemastore.org/prometheus.json"
        },
        {
            name = "prometheus.rules.json",
            description = "Prometheus rules file",
            fileMatch = {"*.rules"},
            url = "https://json.schemastore.org/prometheus.rules.json"
        },
        {
            name = "proxies.json",
            description = "JSON schema for Azure Function Proxies proxies.json files",
            fileMatch = {"proxies.json"},
            url = "https://json.schemastore.org/proxies.json"
        },
        {
            name = "pubspec.yaml",
            description = "Schema for pubspecs, the format used by Dart's dependency manager",
            fileMatch = {"pubspec.yaml"},
            url = "https://json.schemastore.org/pubspec.json"
        },
        {
            name = "pyrseas-0.8.json",
            description = "Pyrseas database schema versioning for Postgres databases, v0.8",
            fileMatch = {"pyrseas-0.8.json"},
            url = "https://json.schemastore.org/pyrseas-0.8.json"
        },
        {
            name = "Red-DiscordBot Сog",
            description = "Red-DiscordBot Сog metadata file",
            fileMatch = {"info.json"},
            url = "https://raw.githubusercontent.com/Cog-Creators/Red-DiscordBot/V3/develop/schema/red_cog.schema.json"
        },
        {
            name = "Red-DiscordBot Сog Repo",
            description = "Red-DiscordBot Сog Repo metadata file",
            fileMatch = {"info.json"},
            url = "https://raw.githubusercontent.com/Cog-Creators/Red-DiscordBot/V3/develop/schema/red_cog_repo.schema.json"
        },
        {
            name = "*.resjson",
            description = "Windows App localization file",
            fileMatch = {"*.resjson"},
            url = "https://json.schemastore.org/resjson.json"
        },
        {
            name = "JSON Resume",
            description = "A JSON format to describe resumes",
            fileMatch = {"resume.json"},
            url = "https://json.schemastore.org/resume.json"
        },
        {
            name = "Renovate",
            description = "Renovate config file (https://github.com/renovatebot/renovate)",
            fileMatch = {
                "renovate.json",
                "renovate.json5",
                ".github/renovate.json",
                ".github/renovate.json5",
                ".renovaterc",
                ".renovaterc.json"
            },
            url = "https://docs.renovatebot.com/renovate-schema.json"
        },
        {
            name = "RoadRunner",
            description = "Spiral Roadrunner config file schema",
            url = "https://raw.githubusercontent.com/spiral/roadrunner-binary/master/schemas/config/2.0.schema.json",
            fileMatch = {".rr*.yml", ".rr*.yaml"},
            versions = {
                ["1.0"] = "https://raw.githubusercontent.com/spiral/roadrunner-binary/master/schemas/config/1.0.schema.json",
                ["2.0"] = "https://raw.githubusercontent.com/spiral/roadrunner-binary/master/schemas/config/2.0.schema.json"
            }
        },
        {
            name = "sarif-1.0.0.json",
            description = "Static Analysis Results Interchange Format (SARIF) version 1",
            url = "https://json.schemastore.org/sarif-1.0.0.json"
        },
        {
            name = "sarif-2.0.0.json",
            description = "Static Analysis Results Interchange Format (SARIF) version 2",
            url = "https://json.schemastore.org/sarif-2.0.0.json"
        },
        {
            name = "sarif-2.1.0-rtm.2",
            description = "Static Analysis Results Format (SARIF), Version 2.1.0-rtm.2",
            url = "https://json.schemastore.org/sarif-2.1.0-rtm.2.json"
        },
        {
            name = "sarif-external-property-file-2.1.0-rtm.2",
            description = "Static Analysis Results Format (SARIF) External Property File Format, Version 2.1.0-rtm.2",
            url = "https://json.schemastore.org/sarif-external-property-file-2.1.0-rtm.2.json"
        },
        {
            name = "sarif-2.1.0-rtm.3",
            description = "Static Analysis Results Format (SARIF), Version 2.1.0-rtm.3",
            url = "https://json.schemastore.org/sarif-2.1.0-rtm.3.json"
        },
        {
            name = "sarif-external-property-file-2.1.0-rtm.3",
            description = "Static Analysis Results Format (SARIF) External Property File Format, Version 2.1.0-rtm.3",
            url = "https://json.schemastore.org/sarif-external-property-file-2.1.0-rtm.3.json"
        },
        {
            name = "sarif-2.1.0-rtm.4",
            description = "Static Analysis Results Format (SARIF), Version 2.1.0-rtm.4",
            url = "https://json.schemastore.org/sarif-2.1.0-rtm.4.json"
        },
        {
            name = "sarif-external-property-file-2.1.0-rtm.4",
            description = "Static Analysis Results Format (SARIF) External Property File Format, Version 2.1.0-rtm.4",
            url = "https://json.schemastore.org/sarif-external-property-file-2.1.0-rtm.4.json"
        },
        {
            name = "sarif-2.1.0-rtm.5",
            description = "Static Analysis Results Format (SARIF), Version 2.1.0-rtm.5",
            url = "https://json.schemastore.org/sarif-2.1.0-rtm.5.json"
        },
        {
            name = "sarif-external-property-file-2.1.0-rtm.5",
            description = "Static Analysis Results Format (SARIF) External Property File Format, Version 2.1.0-rtm.5",
            url = "https://json.schemastore.org/sarif-external-property-file-2.1.0-rtm.5.json"
        },
        {
            name = "sarif-2.1.0",
            description = "Static Analysis Results Format (SARIF), Version 2.1.0",
            url = "https://json.schemastore.org/sarif-2.1.0.json"
        },
        {
            name = "sarif-external-property-file-2.1.0",
            description = "Static Analysis Results Format (SARIF) External Property File Format, Version 2.1.0",
            url = "https://json.schemastore.org/sarif-external-property-file-2.1.0.json"
        },
        {
            name = "Schema Catalog",
            description = "JSON Schema catalog files compatible with SchemaStore.org",
            url = "https://json.schemastore.org/schema-catalog.json"
        },
        {
            name = "schema.org - Action",
            description = "JSON Schema for Action as defined by schema.org",
            url = "https://json.schemastore.org/schema-org-action.json"
        },
        {
            name = "schema.org - ContactPoint",
            description = "JSON Schema for ContactPoint as defined by schema.org",
            url = "https://json.schemastore.org/schema-org-contact-point.json"
        },
        {
            name = "schema.org - Place",
            description = "JSON Schema for Place as defined by schema.org",
            url = "https://json.schemastore.org/schema-org-place.json"
        },
        {
            name = "schema.org - Thing",
            description = "JSON Schema for Thing as defined by schema.org",
            url = "https://json.schemastore.org/schema-org-thing.json"
        },
        {
            name = "Semgrep Rule",
            description = "Semgrep code scanning patterns and rules",
            fileMatch = {".semgrep/**.yaml", ".semgrep/**.yml", ".semgrep.yaml", ".semgrep.yml"},
            url = "https://json.schemastore.org/semgrep.json"
        },
        {
            name = "settings.job",
            description = "Azure Webjob settings file",
            fileMatch = {"settings.job"},
            url = "https://json.schemastore.org/settings.job.json"
        },
        {
            name = "skyuxconfig.json",
            description = "SKY UX CLI configuration file",
            fileMatch = {"skyuxconfig.json", "skyuxconfig.*.json"},
            url = "https://raw.githubusercontent.com/blackbaud/skyux-config/4.0.4/skyuxconfig-schema.json"
        },
        {
            name = "snapcraft",
            description = "snapcraft project  (https://snapcraft.io)",
            fileMatch = {".snapcraft.yaml", "snapcraft.yaml"},
            url = "https://raw.githubusercontent.com/snapcore/snapcraft/4.3/schema/snapcraft.json"
        },
        {
            name = "Solidarity",
            description = "CLI config for enforcing environment settings",
            fileMatch = {".solidarity", ".solidarity.json"},
            url = "https://json.schemastore.org/solidaritySchema.json"
        },
        {
            name = "Source Maps v3",
            description = "Source Map files version 3",
            fileMatch = {"*.map"},
            url = "https://json.schemastore.org/sourcemap-v3.json"
        },
        {
            name = "Sponge Mixin configuration",
            description = "Configuration file for SpongePowered's Mixin library",
            fileMatch = {"*.mixins.json"},
            url = "https://json.schemastore.org/sponge-mixins.json"
        },
        {
            name = ".sprite files",
            description = "Schema for image sprite generation files",
            fileMatch = {"*.sprite"},
            url = "https://json.schemastore.org/sprite.json"
        },
        {
            name = "Azure Static Web Apps configuration file",
            description = "Documentation: https://aka.ms/swa/config-schema",
            fileMatch = {"staticwebapp.config.json"},
            url = "https://json.schemastore.org/staticwebapp.config.json"
        },
        {
            name = "StackHead CLI config",
            description = "Configuration file for StackHead CLI. See https://stackhead.io.",
            fileMatch = {".stackhead-cli.yml"},
            url = "https://schema.stackhead.io/stackhead-cli/tag/v1/-/cli-config.schema.json"
        },
        {
            name = "StackHead module configuration",
            description = "Configuration file for StackHead modules. See https://stackhead.io.",
            fileMatch = {"stackhead-module.yml"},
            url = "https://schema.stackhead.io/stackhead/tag/v1/-/module-config.schema.json"
        },
        {
            name = "StackHead project definition",
            description = "Project definition file for deploying projects with StackHead. See https://stackhead.io.",
            fileMatch = {"*.stackhead.yml", "*.stackhead.yaml"},
            url = "https://schema.stackhead.io/stackhead/tag/v1/-/project-definition.schema.json"
        },
        {
            name = "Stryker Mutator",
            description = "Configuration file for Stryker Mutator, the mutation testing framework for JavaScript and friends. See https://stryker-mutator.io.",
            fileMatch = {"stryker.conf.json", "stryker-*.conf.json"},
            url = "https://raw.githubusercontent.com/stryker-mutator/stryker/v4.0.0/packages/api/schema/stryker-core.json"
        },
        {
            name = "StyleCop Analyzers Configuration",
            description = "Configuration file for StyleCop Analyzers",
            fileMatch = {"stylecop.json"},
            url = "https://raw.githubusercontent.com/DotNetAnalyzers/StyleCopAnalyzers/1.1.118/StyleCop.Analyzers/StyleCop.Analyzers/Settings/stylecop.schema.json"
        },
        {
            name = ".stylelintrc",
            description = "Configuration file for stylelint",
            fileMatch = {".stylelintrc", "stylelintrc.json", ".stylelintrc.json"},
            url = "https://json.schemastore.org/stylelintrc.json"
        },
        {
            name = "Swagger API 2.0",
            description = "Swagger API 2.0 schema",
            fileMatch = {"swagger.json"},
            url = "https://json.schemastore.org/swagger-2.0.json"
        },
        {
            name = "Taurus",
            description = "Taurus bzt cli framework config",
            fileMatch = {"bzt.yml", "bzt.yaml", "taurus.yml", "taurus.yaml"},
            url = "https://json.schemastore.org/taurus.json"
        },
        {
            name = "template.json",
            description = "JSON schema .NET template files",
            fileMatch = {".template.config/template.json"},
            url = "https://json.schemastore.org/template.json"
        },
        {
            name = "templatsources.json",
            description = "SideWaffle template source schema",
            fileMatch = {"templatesources.json"},
            url = "https://json.schemastore.org/templatesources.json"
        },
        {
            name = "tmLanguage",
            description = "Language grammar description files in Textmate and compatible editors",
            fileMatch = {"*.tmLanguage.json"},
            url = "https://raw.githubusercontent.com/Septh/tmlanguage/master/tmLanguage.schema.json"
        },
        {
            name = ".travis.yml",
            description = "Travis CI configuration file",
            fileMatch = {".travis.yml"},
            url = "https://json.schemastore.org/travis.json"
        },
        {
            name = "Traefik v2",
            description = "Traefik v2 YAML configuration file",
            fileMatch = {"traefik.yml", "traefik.yaml"},
            url = "https://json.schemastore.org/traefik-v2.json"
        },
        {
            name = "Traefik v2 File Provider",
            description = "Traefik v2 Dynamic Configuration File Provider",
            url = "https://json.schemastore.org/traefik-v2-file-provider.json"
        },
        {
            name = "tsconfig.json",
            description = "TypeScript compiler configuration file",
            fileMatch = {"tsconfig.json"},
            url = "https://json.schemastore.org/tsconfig.json"
        },
        {
            name = "tsd.json",
            description = "JSON schema for DefinatelyTyped description manager (TSD)",
            fileMatch = {"tsd.json"},
            url = "https://json.schemastore.org/tsd.json"
        },
        {
            name = "tsdrc.json",
            description = "TypeScript Definition manager (tsd) global settings file",
            fileMatch = {".tsdrc"},
            url = "https://json.schemastore.org/tsdrc.json"
        },
        {
            name = "ts-force-config.json",
            description = "Generated Typescript classes for Salesforce",
            fileMatch = {"ts-force-config.json"},
            url = "https://json.schemastore.org/ts-force-config.json"
        },
        {
            name = "tslint.json",
            description = "TypeScript Lint configuration file",
            fileMatch = {"tslint.json", "tslint.yaml", "tslint.yml"},
            url = "https://json.schemastore.org/tslint.json"
        },
        {
            name = "typewiz.json",
            description = "Typewiz configuration file",
            fileMatch = {"typewiz.json"},
            url = "https://json.schemastore.org/typewiz.json"
        },
        {
            name = "typings.json",
            description = "Typings TypeScript definitions manager definition file",
            fileMatch = {"typings.json"},
            url = "https://json.schemastore.org/typings.json"
        },
        {
            name = "typingsrc.json",
            description = "Typings TypeScript definitions manager configuration file",
            fileMatch = {".typingsrc"},
            url = "https://json.schemastore.org/typingsrc.json"
        },
        {
            name = "up.json",
            description = "Up configuration file",
            fileMatch = {"up.json"},
            url = "https://json.schemastore.org/up.json"
        },
        {
            name = "UI5 Manifest",
            description = "UI5 Manifest (manifest.json)",
            fileMatch = {"webapp/manifest.json", "src/main/webapp/manifest.json"},
            url = "https://raw.githubusercontent.com/SAP/ui5-manifest/master/schema.json"
        },
        {
            name = "ui5.yaml",
            description = "UI5 Tooling Configuration File (ui5.yaml)",
            fileMatch = {"ui5.yaml", "*-ui5.yaml", "*.ui5.yaml", "ui5-deploy.yaml", "ui5-dist.yaml", "ui5-local.yaml"},
            url = "https://sap.github.io/ui5-tooling/schema/ui5.yaml.json"
        },
        {
            name = "vega.json",
            description = "Vega visualization specification file",
            fileMatch = {"*.vg", "*.vg.json"},
            url = "https://json.schemastore.org/vega.json"
        },
        {
            name = "vega-lite.json",
            description = "Vega-Lite visualization specification file",
            fileMatch = {"*.vl", "*.vl.json"},
            url = "https://json.schemastore.org/vega-lite.json"
        },
        {
            name = "Vela Pipeline Configuration",
            description = "Vela Pipeline Configuration File",
            fileMatch = {".vela.yml", ".vela.yaml"},
            url = "https://github.com/go-vela/types/releases/latest/download/schema.json"
        },
        {
            name = "version.json",
            description = "A project version descriptor file used by Nerdbank.GitVersioning",
            fileMatch = {"version.json"},
            url = "https://raw.githubusercontent.com/dotnet/Nerdbank.GitVersioning/v3.3.37/src/NerdBank.GitVersioning/version.schema.json"
        },
        {
            name = "vim-addon-info",
            description = "JSON schema for vim plugin addon-info.json metadata files",
            fileMatch = {"*vim*/addon-info.json"},
            url = "https://json.schemastore.org/vim-addon-info.json"
        },
        {
            name = "vsls.json",
            description = "Visual Studio Live Share configuration file",
            fileMatch = {".vsls.json"},
            url = "https://json.schemastore.org/vsls.json"
        },
        {
            name = "vs-2017.3.host.json",
            description = "JSON schema for Visual Studio template host file",
            fileMatch = {"vs-2017.3.host.json"},
            url = "https://json.schemastore.org/vs-2017.3.host.json"
        },
        {
            name = "vs-nesting.json",
            description = "JSON schema for Visual Studio's file nesting feature",
            fileMatch = {"*.filenesting.json", ".filenesting.json"},
            url = "https://json.schemastore.org/vs-nesting.json"
        },
        {
            name = ".vsconfig",
            description = "JSON schema for Visual Studio component configuration files",
            fileMatch = {"*.vsconfig"},
            url = "https://json.schemastore.org/vsconfig.json"
        },
        {
            name = ".vsext",
            description = "JSON schema for Visual Studio extension pack manifests",
            fileMatch = {"*.vsext"},
            url = "https://json.schemastore.org/vsext.json"
        },
        {
            name = "VSIX CLI publishing",
            description = "JSON schema for Visual Studio extension publishing",
            fileMatch = {"vs-publish.json"},
            url = "https://json.schemastore.org/vsix-publish.json"
        },
        {
            name = "vss-extension.json",
            description = "JSON Schema for Azure DevOps Extensions",
            fileMatch = {"vss-extension.json"},
            url = "https://json.schemastore.org/vss-extension.json"
        },
        {
            name = "WebExtensions",
            description = "JSON schema for WebExtension manifest files",
            fileMatch = {"manifest.json"},
            url = "https://json.schemastore.org/webextension.json"
        },
        {
            name = "Web App Manifest",
            description = "Web Application manifest file",
            fileMatch = {"manifest.json", "*.webmanifest"},
            url = "https://json.schemastore.org/web-manifest-combined.json"
        },
        {
            name = "webjobs-list.json",
            description = "Azure Webjob list file",
            fileMatch = {"webjobs-list.json"},
            url = "https://json.schemastore.org/webjobs-list.json"
        },
        {
            name = "webjobpublishsettings.json",
            description = "Azure Webjobs publish settings file",
            fileMatch = {"webjobpublishsettings.json"},
            url = "https://json.schemastore.org/webjob-publish-settings.json"
        },
        {
            name = "Web types",
            description = "JSON standard for web component libraries metadata",
            fileMatch = {"web-types.json", "*.web-types.json"},
            url = "https://json.schemastore.org/web-types.json"
        },
        {name = "JSON-stat 2.0", description = "JSON-stat 2.0 Schema", url = "https://json-stat.org/format/schema/2.0/"},
        {
            name = "KSP-AVC",
            description = "The .version file format for KSP-AVC",
            fileMatch = {"*.version"},
            url = "https://raw.githubusercontent.com/linuxgurugamer/KSPAddonVersionChecker/1.4.1.5/KSP-AVC.schema.json"
        },
        {
            name = "KSP-CKAN",
            description = "Metadata spec for KSP-CKAN",
            fileMatch = {"*.ckan"},
            url = "https://raw.githubusercontent.com/KSP-CKAN/CKAN/v1.28.0/CKAN.schema"
        },
        {
            name = "JSON Schema Draft 4",
            description = "Meta-validation schema for JSON Schema Draft 4",
            url = "https://json-schema.org/draft-04/schema"
        },
        {
            name = "JSON Schema Draft 7",
            description = "Meta-validation schema for JSON Schema Draft 7",
            url = "https://json-schema.org/draft-07/schema"
        },
        {
            name = "JSON Schema Draft 8",
            description = "Meta-validation schema for JSON Schema Draft 8",
            url = "https://json-schema.org/draft/2019-09/schema"
        },
        {
            name = "xunit.runner.json",
            description = "xUnit.net runner configuration file",
            fileMatch = {"xunit.runner.json"},
            url = "https://json.schemastore.org/xunit.runner.schema.json"
        },
        {
            name = "servicehub.service.json",
            description = "Microsoft ServiceHub Service",
            fileMatch = {"*.servicehub.service.json"},
            url = "https://json.schemastore.org/servicehub.service.schema.json"
        },
        {
            name = "servicehub.config.json",
            description = "Microsoft ServiceHub Configuration",
            fileMatch = {"servicehub.config.json"},
            url = "https://json.schemastore.org/servicehub.config.schema.json"
        },
        {
            name = ".cryproj engine-5.2",
            description = "A JSON schema for CRYENGINE projects (.cryproj files)",
            fileMatch = {"*.cryproj"},
            url = "https://json.schemastore.org/cryproj.52.schema.json"
        },
        {
            name = ".cryproj engine-5.3",
            description = "A JSON schema for CRYENGINE projects (.cryproj files)",
            fileMatch = {"*.cryproj"},
            url = "https://json.schemastore.org/cryproj.53.schema.json"
        },
        {
            name = ".cryproj engine-5.4",
            description = "A JSON schema for CRYENGINE projects (.cryproj files)",
            fileMatch = {"*.cryproj"},
            url = "https://json.schemastore.org/cryproj.54.schema.json"
        },
        {
            name = ".cryproj engine-5.5",
            description = "A JSON schema for CRYENGINE projects (.cryproj files)",
            fileMatch = {"*.cryproj"},
            url = "https://json.schemastore.org/cryproj.55.schema.json"
        },
        {
            name = ".cryproj engine-dev",
            description = "A JSON schema for CRYENGINE projects (.cryproj files)",
            fileMatch = {"*.cryproj"},
            url = "https://json.schemastore.org/cryproj.dev.schema.json"
        },
        {
            name = ".cryproj (generic)",
            description = "A JSON schema for CRYENGINE projects (.cryproj files)",
            fileMatch = {"*.cryproj"},
            url = "https://json.schemastore.org/cryproj.json"
        },
        {
            name = "typedoc.json",
            description = "A JSON schema for the Typedoc configuration file",
            fileMatch = {"typedoc.json"},
            url = "https://typedoc.org/schema.json"
        },
        {
            name = "huskyrc",
            description = "Husky can prevent bad `git commit`, `git push` and more 🐶 woof!",
            fileMatch = {".huskyrc", ".huskyrc.json"},
            url = "https://json.schemastore.org/huskyrc.json"
        },
        {
            name = ".lintstagedrc",
            description = "JSON schema for lint-staged config",
            fileMatch = {".lintstagedrc", ".lintstagedrc.json"},
            url = "https://json.schemastore.org/lintstagedrc.schema.json"
        },
        {
            name = "mta.yaml",
            description = "A JSON schema for MTA projects v3.3",
            fileMatch = {"mta.yaml", "mta.yml"},
            url = "https://json.schemastore.org/mta.json"
        },
        {
            name = "mtad.yaml",
            description = "A JSON schema for MTA deployment descriptors v3.3",
            fileMatch = {"mtad.yaml", "mtad.yml"},
            url = "https://json.schemastore.org/mtad.json"
        },
        {
            name = ".mtaext",
            description = "A JSON schema for MTA extension descriptors v3.3",
            fileMatch = {"*.mtaext"},
            url = "https://json.schemastore.org/mtaext.json"
        },
        {
            name = "xs-app.json",
            description = "JSON schema for the SAP Application Router v8.2.2",
            fileMatch = {"xs-app.json"},
            url = "https://json.schemastore.org/xs-app.json"
        },
        {
            name = "Opctl",
            description = "Opctl schema for describing an op",
            url = "https://json.schemastore.org/opspec-io-0.1.7.json",
            fileMatch = {".opspec/*/*.yml", ".opspec/*/*.yaml"}
        },
        {
            name = "HEMTT",
            description = "HEMTT Project File",
            url = "https://json.schemastore.org/hemtt-0.6.2.json",
            fileMatch = {"hemtt.json", "hemtt.toml"},
            versions = {["0.6.2"] = "https://json.schemastore.org/hemtt-0.6.2.json"}
        },
        {
            name = "now",
            description = "ZEIT Now project configuration file",
            fileMatch = {"now.json"},
            url = "https://json.schemastore.org/now.json"
        },
        {
            name = "taskcat",
            description = "taskcat",
            fileMatch = {".taskcat.yml"},
            url = "https://raw.githubusercontent.com/aws-quickstart/taskcat/0.9.20/taskcat/cfg/config_schema.json"
        },
        {
            name = "BizTalkServerApplicationSchema",
            description = "BizTalk server application inventory json file.",
            fileMatch = {"BizTalkServerInventory.json"},
            url = "https://json.schemastore.org/BizTalkServerApplicationSchema.json"
        },
        {
            name = "httpmockrc",
            description = "Http-mocker is a tool for mock local requests or proxy remote requests.",
            fileMatch = {".httpmockrc", ".httpmock.json"},
            url = "https://json.schemastore.org/httpmockrc.json"
        },
        {
            name = "neoload",
            description = "Neotys as-code load test specification, more at: https://github.com/Neotys-Labs/neoload-cli",
            fileMatch = {".nl.yaml", ".nl.yml", ".nl.json", ".neoload.yaml", ".neoload.yml", ".neoload.json"},
            url = "https://raw.githubusercontent.com/Neotys-Labs/neoload-cli/1.1.4/resources/as-code.latest.schema.json"
        },
        {
            name = "release drafter",
            description = "Release Drafter configuration file",
            fileMatch = {".github/release-drafter.yml"},
            url = "https://raw.githubusercontent.com/release-drafter/release-drafter/master/schema.json"
        },
        {
            name = "zuul",
            description = "Zuul CI configuration file",
            fileMatch = {"*zuul.d/*.yaml", "*/.zuul.yaml"},
            url = "https://raw.githubusercontent.com/pycontribs/zuul-lint/0.1.1/zuul_lint/zuul-schema.json"
        },
        {
            name = "Briefcase",
            description = "Microsoft Briefcase configuration file",
            fileMatch = {"briefcase.yaml"},
            url = "https://raw.githubusercontent.com/microsoft/Briefcase/master/mlbriefcase/briefcase-schema.json"
        },
        {
            name = "httparchive",
            description = "HTTP Archive",
            fileMatch = {"*.har"},
            url = "https://raw.githubusercontent.com/ahmadnassri/har-schema/v2.0.0/lib/har.json"
        },
        {
            name = "jsdoc",
            description = "JSDoc configuration file",
            fileMatch = {"conf.js*", "jsdoc.js*"},
            url = "https://json.schemastore.org/jsdoc-1.0.0.json"
        },
        {
            name = "Ray",
            description = "Ray autocluster configuration file",
            fileMatch = {"ray-*-cluster.yaml"},
            url = "https://raw.githubusercontent.com/ray-project/ray/ray-1.0.0/python/ray/autoscaler/ray-schema.json"
        },
        {
            name = "Hadolint",
            description = "A smarter Dockerfile linter that helps you build best practice Docker images.",
            fileMatch = {".hadolint.yaml", "hadolint.yaml", ".hadolint.yml", "hadolint.yml"},
            url = "https://raw.githubusercontent.com/hadolint/hadolint/master/contrib/hadolint.json"
        },
        {
            name = "helmfile",
            description = "Helmfile is a declarative spec for deploying helm charts",
            fileMatch = {"helmfile.yaml", "helmfile.d/**/*.yaml"},
            url = "https://json.schemastore.org/helmfile.json"
        },
        {
            name = "Container Structure Test",
            description = "The Container Structure Tests provide a powerful framework to validate the structure of a container image.",
            fileMatch = {"container-structure-test.yaml", "structure-test.yaml"},
            url = "https://json.schemastore.org/container-structure-test.json"
        },
        {
            name = "Žinoma",
            description = "Žinoma incremental build configuration",
            fileMatch = {"zinoma.yml"},
            url = "https://github.com/fbecart/zinoma/releases/latest/download/zinoma-schema.json"
        },
        {
            name = "Windows Package Manager Singleton Manifest",
            description = "Windows Package Manager Singleton Manifest file",
            url = "https://json.schemastore.org/winget-pkgs-singleton-1.0.0.json",
            fileMatch = {"manifests/*/*/*.yaml", "manifests/?/*/*/*/*.*.yaml"},
            versions = {
                ["0.1"] = "https://json.schemastore.org/winget-pkgs-singleton-0.1.json",
                ["1.0.0"] = "https://json.schemastore.org/winget-pkgs-singleton-1.0.0.json"
            }
        },
        {
            name = "Windows Package Manager Installer Manifest",
            description = "Windows Package Manager Installer Manifest file, used for detailing installer specific metadata.",
            url = "https://json.schemastore.org/winget-pkgs-installer-1.0.0.json",
            fileMatch = {"manifests/?/*/*/*/*.*.installer.yaml"}
        },
        {
            name = "Windows Package Manager Locale Manifest",
            description = "Windows Package Manager Locale Manifest file, used for detailing locale specific metadata.",
            url = "https://json.schemastore.org/winget-pkgs-locale-1.0.0.json",
            fileMatch = {"manifests/?/*/*/*/*.*.locale@(.en-US|fr-FR|it-IT|ja-JP|ko-KR|pt-BR|ru-RU|zh-CN|zh-TW).yaml"}
        },
        {
            name = ".commitlintrc",
            description = "JSON schema for commitlint configuration files",
            fileMatch = {".commitlintrc", ".commitlintrc.json"},
            url = "https://json.schemastore.org/commitlintrc.json"
        },
        {
            name = "Uniswap Token List",
            description = "A list of tokens compatible with the Uniswap Interface",
            fileMatch = {"*.tokenlist.json"},
            url = "https://uniswap.org/tokenlist.schema.json"
        },
        {
            name = "Yippee-Ki-JSON configuration YML",
            description = "Action and rule configuration descriptor for Yippee-Ki-JSON transformations.",
            fileMatch = {"**/yippee-*.yml", "**/*.yippee.yml"},
            url = "https://raw.githubusercontent.com/nagyesta/yippee-ki-json/v1.3.2/schema/yippee-ki-json_config_schema.json",
            versions = {
                ["1.1.2"] = "https://raw.githubusercontent.com/nagyesta/yippee-ki-json/v1.1.2/schema/yippee-ki-json_config_schema.json",
                latest = "https://raw.githubusercontent.com/nagyesta/yippee-ki-json/main/schema/yippee-ki-json_config_schema.json"
            }
        },
        {
            name = "docker-compose.yml",
            description = "The Compose specification establishes a standard for the definition of multi-container platform-agnostic applications. ",
            fileMatch = {
                "**/docker-compose.yml",
                "**/docker-compose.yaml",
                "**/docker-compose.*.yml",
                "**/docker-compose.*.yaml",
                "**/compose.yml",
                "**/compose.yaml",
                "**/compose.*.yml",
                "**/compose.*.yaml"
            },
            url = "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"
        },
        {
            name = "devinit",
            description = "Devinit configuration file schema.",
            url = "https://json.schemastore.org/devinit.schema-6.0.json",
            fileMatch = {"devinit.json", ".devinit.json"},
            versions = {
                ["1.0"] = "https://json.schemastore.org/devinit.schema-1.0.json",
                ["2.0"] = "https://json.schemastore.org/devinit.schema-2.0.json",
                ["3.0"] = "https://json.schemastore.org/devinit.schema-3.0.json",
                ["4.0"] = "https://json.schemastore.org/devinit.schema-4.0.json",
                ["5.0"] = "https://json.schemastore.org/devinit.schema-5.0.json",
                ["6.0"] = "https://json.schemastore.org/devinit.schema-6.0.json"
            }
        },
        {
            name = "tsoa",
            description = "JSON Schema for the tsoa configuration file",
            url = "https://json.schemastore.org/tsoa.json",
            fileMatch = {"**/tsoa.json"}
        },
        {
            name = "API Builder",
            description = "apibuilder.io schema",
            fileMatch = {"**/api.json"},
            url = "https://json.schemastore.org/apibuilder.json"
        },
        {
            name = "Gradle Enterprise",
            description = "Gradle Enterprise configuration schema",
            fileMatch = {"*gradle-enterprise.yml", "*gradle-enterprise.yaml"},
            url = "https://docs.gradle.com/enterprise/admin/schema/gradle-enterprise-config-schema-2.json",
            versions = {
                ["1.0"] = "https://docs.gradle.com/enterprise/admin/schema/gradle-enterprise-config-schema-1.json",
                ["2.0"] = "https://docs.gradle.com/enterprise/admin/schema/gradle-enterprise-config-schema-2.json"
            }
        },
        {
            name = ".yarnrc.yml",
            description = "JSON Schema for Yarnrc files",
            fileMatch = {".yarnrc.yml"},
            url = "https://yarnpkg.com/configuration/yarnrc.json"
        },
        {
            name = "beau.yml",
            description = "JSON Schema for a Beaujs Requests file.",
            fileMatch = {"beau.yml"},
            url = "https://beaujs.com/schema.json"
        },
        {
            name = "comet",
            description = "JSON Schema for a Comet Data Pipeline.",
            fileMatch = {"*.comet.yaml", "*.comet.yml"},
            url = "https://json.schemastore.org/comet.json"
        },
        {
            name = "swcrc",
            description = "JSON Schema for swc configuration files.",
            fileMatch = {".swcrc"},
            url = "https://json.schemastore.org/swcrc.json"
        },
        {
            name = "OpenWeather Road Risk API",
            description = "JSON Schema for OpenWeather Road Risk API responses.",
            fileMatch = {},
            url = "https://json.schemastore.org/openweather.roadrisk.json"
        },
        {
            name = "OpenWeather Current Weather API",
            description = "JSON Schema for OpenWeather Current Weather API responses.",
            fileMatch = {},
            url = "https://json.schemastore.org/openweather.current.json"
        },
        {
            name = "JSON-e templates",
            description = "JSON Schema for JSON-e templates.",
            fileMatch = {},
            url = "https://json.schemastore.org/jsone.json"
        },
        {
            name = "Taskfile YAML Schema",
            description = "JSON Schema for Taskfile files.",
            fileMatch = {"Taskfile.yaml", "Taskfile.yml"},
            url = "https://json.schemastore.org/taskfile.json"
        },
        {
            name = "Containerlab",
            description = "JSON Schema for Containerlab topology definition files.",
            fileMatch = {"*-clab.yaml", "*-clab.yml", "*.clab.yaml", "*.clab.yml"},
            url = "https://raw.githubusercontent.com/srl-labs/containerlab/master/schemas/clab.schema.json"
        },
        {
            name = "SpecIF",
            description = "The Specification Integration Facility (SpecIF) integrates partial system models from different methods and tools in a semantic net. See https://specif.de and https://github.com/GfSE.",
            url = "https://json.schemastore.org/specif-1.0.json",
            fileMatch = {"*.specif", "*.specif.json"},
            versions = {["1.0"] = "https://json.schemastore.org/specif-1.0.json"}
        },
        {
            name = "User Journey Map YAML Schema",
            description = "JSON Schema for user journey map definition files.",
            fileMatch = {"*.jm.yaml", "*.jm.yml"},
            url = "https://raw.githubusercontent.com/arvinxx/components/master/packages/journey-map/schema/journey-map.schema.json"
        },
        {
            name = "RKE Cluster Configuration YAML Schema",
            description = "YAML Schema for the cluster.yml configuration file for RKE",
            fileMatch = {"cluster.yml", "cluster.yaml"},
            url = "https://raw.githubusercontent.com/dcermak/vscode-rke-cluster-config/main/schemas/cluster.yml.json"
        },
        {
            name = "RKE Cluster Configuration JSON Schema",
            description = "JSON Schema for the cluster.json configuration file for RKE",
            fileMatch = {"cluster.json"},
            url = "https://raw.githubusercontent.com/dcermak/vscode-rke-cluster-config/main/schemas/cluster.json"
        },
        {
            name = "Liquibase",
            description = "Use this schema to get auto-suggestions for your liquibase JSON/YAML files.",
            fileMatch = {"**/db/changelog/**/*.yaml", "**/db/changelog/**/*.yml", "**/db/changelog/**/*.json"},
            url = "https://json.schemastore.org/liquibase.json"
        }
    }
}