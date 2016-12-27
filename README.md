# SOQLBuilder
Quickly query in Apex (Salesforce). I built this because sometimes you'll need to pull a bunch of fields from an object which creates messy code. SOQL doesn't support something like "SELECT * FROM ..." so this can help with that.

## To do
*	Write test class
*	Write samples
*	Support other SOQL functionality (i.e. group by)

## Moving forward
I plan on updating some of the code to behave similarly to the orderBy function. For example, whereBy() can be a little messy to write. It would be nice to write something like:
```apex
/**
 * soql.enclose() would wrap the string
 * in single quotes
 * 
 * Example
 *	value becomes 'value' therefore making the
 *	where condition 'WHERE Field__c = \'value\''
 *
 * @param Field name
 * @param Value
 * @param Is equal to?
 */
soql.whereBy('Field__c', soql.enclose('value'), true);
```

I might keep the original whereBy function and just overload it with the above params.

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

// ... recast to your object ...
My_Custom_Object__c obj = (My_Custom_Object__c)results[0];
```