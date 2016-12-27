/**
 * SOQLBuilder
 * 
 * @author Jordan L. Johnson
 * @date 12/20/2016
 * 
 * Allows devs to easily query objects
 * in SOQL. I got tired of writing all
 * my queries manually so I made this 
 * tool to simplify things.
 * 
 * Major features:
 *      Select all fields
 *      Works with any standard or custom object
 */
/**
 * Example use:
 * 
 * SOQLBuilder soql = new SOQLBuilder();
 * 
 * Schema.DescribeSObjectResult obj = My_Object__c.SObjectType.getDescribe();
 * 
 * soql.init(obj);
 * soql.limitTo(1);
 * List<SObject> results = soql.selectAllFields();
 * 
 * My_Object__c record = (My_Object__c)results[0];
 */
public class SOQLBuilder {
    /**
     * Our dynamic object stored from init()
     * to be used in methods later
     */
    private transient Schema.DescribeSObjectResult obj;
    
    /**
     * Stores our field information
     * 
     * @param String Field API Name
     * @param DescribeFieldResult Field data
     */
    private transient Map<String, DescribeFieldResult> fields;
    
    /**
     * Results from query
     */
    private List<SObject> results;
    
    /**
     * Any conditions to the query should
     * go through the whereBy() method
     */
    private String condition = null;
    
    /**
     * Any record limits should go through
     * the limitTo() method
     */
    private String limited = null;
    
    /**
     * Any order set to the query should
     * go through the orderBy() method
     */
    private String orderResults = null;
    
    /**
     * Call this method to get started with 
     * querying the specified object
     * 
     * Example:
     *  soql.init(My_Object__c.SObjectType.getDescribe());
     *
     * @param obj Object to query
     */
    public void init(String obj) {
        SObjectType objToken = Schema.getGlobalDescribe().get(obj);
        this.obj = objToken.getDescribe();
        
        fields = new Map<String, DescribeFieldResult>();
        results = new List<SObject>();
        
        condition = limited = orderResults = null;
        
        describeFields();
    }
    
    /**
     * Get field data and store it in
     * field maps to be used later
     */
    private void describeFields() {
        Map<String, SObjectField> objFields = obj.fields.getMap();
        
        for(String field : objFields.keySet()) {
            Schema.DescribeFieldResult result = objFields.get(field).getDescribe();
            
            fields.put(field, result);
        }
    }
    
    /**
     * Do not use this function more than once.
     * 
     * Specify a condition to the query
     * 
     * Example:
     *  soql.whereBy('Name = \'My Name\'');
     *
     * @param condition String to set WHERE condition
     */
    public void whereBy(String condition) {
        this.condition = ' WHERE ' + condition;
    }
    
    /**
     * Do not use this function more than once.
     * 
     * Specify a limit to the returned results
     * 
     * Example:
     *  soql.limitTo(1)
     * 
     * @param count Amount of records allowed to return
     */
    public void limitTo(Integer count) {
        limited = ' LIMIT ' + count;
    }
    
    /**
     * Do not use this function more than once.
     *
     * Specify the order of returned records.
     * 
     * Example:
     *  soql.orderBy('My_Field__c', 'ASC');
     * 
     * @param fieldName Name of field in fields map
     * @param orderType ASC or DESC
     */
    public void orderBy(String fieldName, String orderType) {
        if(fields.get(fieldName) == null)
            return;
        
        orderResults = 'ORDER BY ' + fieldName + ' ' + orderType;
    }
    
    /**
     * Select all fields from an object
     * and return a list of records
     */
    public List<SObject> selectAllFields() {
        String query = 'SELECT ';
        
        /**
         * Append fields to query
         */
        for(DescribeFieldResult field : fields.values()) {
            String fieldName = field.getName();
            
            query += fieldName + ', ';
        }
        
        // remove last comma
        query = query.removeEnd(', ');
        
        /**
         * Get object name to append to query
         */
        String objName = obj.getName();
        query += ' FROM ' + objName;
        
        if(condition != null)
            query += condition;
            
        if(limited != null)
            query += limited;
            
        if(orderResults != null)
            query += orderResults;
            
        System.Debug('qry::' + query);
        
        results = Database.query(query);
        return results;
    }
    
    /**
     * Return results from a previous query
     */
    public List<SObject> getResults() {
        return results;
    }
}