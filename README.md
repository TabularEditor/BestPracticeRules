# Best Practice Rules
This repository holds a recommended set of rules for the [Best Practice Analyzer](https://github.com/otykier/TabularEditor/wiki/Best-Practice-Analyzer) of [Tabular Editor](https://tabulareditor.github.io/) .

To use these rules, simply download the BPARules.json file from the releases page. Store the file in one of the following locations:

* `%AppData%\..\Local\TabularEditor` to make the rules available only for you.
* `%ProgramData%\TabularEditor` to make the rules available for everyone on your local machine.

...and restart Tabular Editor. You should then see the rules show up in Best Practice Analyzer:

![image](https://user-images.githubusercontent.com/8976200/31409928-d60dc69c-ae0d-11e7-9372-6944dafec1ee.png)

## Contributing

The community is encouraged to contribute rules to the collection of Best Practices published here. You can contribute in various ways:

- If you have an idea for a Best Practice Rule, [open a new \[Rule Request\] issue](https://github.com/TabularEditor/BestPracticeRules/issues/new?title=[Rule%20Request]%20Provide%20short%20rule%20description) describing what you would like the rule to do. Someone from the community will then provide the Dynamic LINQ expression to use in the Best Practice Analyzer, so you can validate if the rule behaves as you expect.
- If you have already created a rule in Best Practice Analyzer, [open a new \[Rule Submit\] issue](https://github.com/TabularEditor/BestPracticeRules/issues/new?title=[Rule%20Submit]%20Your%20rule%20name) and attach the JSON definition of your rule (see below). The community will evaluate whether the rule will make it into the set of recommended Best Practices.
- If you have a question regarding how to use the Best Practice Analyzer or if you are missing some features of the Dynamic LINQ expression language, [open a new issue](https://github.com/otykier/TabularEditor/issues/new) on the main Tabular Editor repository.

### Conventions

Rules should be submitted in their JSON representation:

```json
{
  "ID": string,
  "Name": string,
  "Category": string,
  "Description": string,
  "Severity": int,
  "Scope": string,
  "Expression": string,
  "FixExpression": string (optional),
  "Remarks": string (optional)
}
```

Rule **ID** must be META_ALL_UPPERCASE_WITH_UNDERSCORES, and include the category prefix (see below). Rule **Name** should be proper case and kept as short as possible, while still describing the essential function of the rule. Rule **Description** should contain a detailed developer-oriented description of the rule and suggestions on how to fix objects that are catched by the rule. Rule **Severity** should be an integer between 1 and 5:

1: Not important / cosmetic only
2: Minor importance / may cause end-user confusion or a less-than-optimal user experience
3: Important / may cause functional issues, performance degradation or end-user confusion
4: Very important / similar to 3, but with a higher risk of causing issues
5: Critical / similar to 4, but guaranteed to cause issues such as deployment/processing errors or logical errors

You may add **Remarks** to the rule to provide comments to the community regarding the behaviour and reasoning behind the rule, and also any limitations or exceptions.

Use one of the following values for the **Category** of the rule:

- **DAX Expressions** (Prefix: DAX)  
 Rules that relate to the way DAX formulas are written, for example to encourage the use of `DIVIDE(<numerator>,<denominator>)` instead of `<numerator> / <denominator>`.
- **Metadata** (Prefix: META)  
 Rules that relate to metadata that alter the behaviour of client tools when browsing the model. The *SummarizeBy* property of columns is an example of such metadata.
- **Model Layout** (Prefix: LAYOUT)  
 Rules that govern visibility, perspectives and localization of objects in the model. For example, whether objects should be visible or not given certain conditions.
- **Performance** (Prefix: PERF)  
 Rules that are transparent to model users, but may impact processing or querying performance of the model.
- **Naming** (Prefix: NAME)
 Rules that enforce specific naming conventions.

More categories may be added over time.

**Expression** is the [Dynamic LINQ query](https://github.com/otykier/TabularEditor/wiki/Best-Practice-Analyzer#rule-expression-samples) that will identify objects in violation of the rule. **FixExpression** is an optional expression of the form `PropertyName = Value` which will be applied to all objects in violation of the rule, if the developer lets the Best Practice Analyzer "fix" the rule.
