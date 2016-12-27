# SOQLBuilder
Quickly query in Apex (Salesforce). I built this because sometimes you'll need to pull a bunch of fields from an object which creates messy code.

## To do
*	Write test class
*	Write samples
*	Support other SOQL functionality (i.e. group by)

## How to use
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
// ...

soql.whereBy('Field__c = \'value\'');

// ...
```

### limitTo
Only select X amount of records.

```apex
// ...

soql.limitTo(5);

// ...
```

### orderBy
Order records ASC or DESC

```apex
// ...

soql.orderBy('Field__c', 'ASC');

// ...