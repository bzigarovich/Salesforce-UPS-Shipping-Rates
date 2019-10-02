/**
 * Rate information class for a shipping provider.
 * @author Brian Zigarovich
 */
public with sharing class RateInfo {
    
    /**
     * The shipping option name.
     */
    @AuraEnabled
    public String name { get; set; }

    /**
     * The shipping option transportation cost.
     */
    @AuraEnabled
    public Decimal transportationCost { get; set; }

    /**
     * The shipping option variable cost.
     */
    @AuraEnabled
    public Decimal optionCost { get; set; }

    /**
     * The shipping option total cost.
     */
    @AuraEnabled
    public Decimal totalCost { get; set; }

    /**
     * The currency code
     */
    @AuraEnabled
    public String currencyCode { get; set; }

    /**
     * The billed weight.
     */
    @AuraEnabled
    public Decimal billedWeight { get; set; }

    /**
     * The actual weight.
     */
    @AuraEnabled
    public Decimal actualWeight { get; set; }

    /**
     * The weight units.
     */
    @AuraEnabled
    public String weightUnits { get; set; }

    /**
     * Constructor.
     */
    public RateInfo(String name, Decimal transCost, Decimal optionCost,
            Decimal totalCost, String currencyCode, Decimal billedWeight,
            Decimal actualWeight, String weightUnits) {
        this.name = name;
        this.transportationCost = transCost;
        this.optionCost = optionCost;
        this.totalCost = totalCost;
        this.currencyCode = currencyCode;
        this.billedWeight = billedWeight;
        this.actualWeight = actualWeight;
        this.weightUnits = weightUnits;
    }

    /**
     * Determines if two objects are equal.
     * @param anObject the  RateInfo object to compare
     * @return true if the objects are equal; otherwise false.
     */
    public  Boolean equals(RateInfo anObject) {
        return this.name == anObject.name &&
            this.transportationCost == anObject.transportationCost &&
            this.optionCost == anObject.optionCost &&
            this.totalCost == anObject.totalCost &&
            this.currencyCode == anObject.currencyCode &&
            this.billedWeight == anObject.billedWeight &&
            this.actualWeight == anObject.actualWeight &&
            this.weightUnits == anObject.weightUnits;
    }
}