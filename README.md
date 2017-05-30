# SOQLBuilder (discontinued)
Quickly query in Apex (Salesforce). I built this because sometimes you'll need to pull a bunch of fields from an object which creates messy code. SOQL doesn't support something like "SELECT * FROM ..." so this can help with that.

## How to use
### Contents
*	[Standard Usage](#standard-usage)
*	[whereBy](#whereBy)
*	[limitTo](#limitTo)
*	[orderBy](#orderBy)
*	[selectAllFields](#selectAllFields)

### Standard Usage
```apex
SOQLBuilder soql = new SOQLBuilder();

soql.init('My_Custom_Object__c');
soql.whereBy('Name = \'My record!\'');

List<SObject> results = soql.selectAllFields();
```

### whereBy
Conditional for query.

```apex
soql.whereBy('Field__c = \'value\'');
```

### limitTo
Only select X amount of records.

```apex
soql.limitTo(5);
```

### orderBy
Order records ASC or DESC

```apex
soql.orderBy('Field__c', 'ASC');
```

### selectAllFields
```apex
List<SObject> results = soql.selectAllFields();

// recast to your object
My_Custom_Object__c obj = (My_Custom_Object__c)results[0];
```
