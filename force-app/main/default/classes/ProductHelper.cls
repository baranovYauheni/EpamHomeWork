public with sharing class ProductHelper {
    public ProductHelper() { }

    private static Boolean flag = true;

    public static void SingleRun(List<Product2> products){
        if(flag) {
            flag = false;
            Product2 prod = new Product2();
            insert prod;          
        }
    }
}
