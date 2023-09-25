package com.ebaylikeproject.auction;

public class AutoBidderInfo {
	
	private String name;
    private String email;
    private int auctionId;
    private double startingCost;
    private double currentPrice;
    private String latestBidBy;
    private double upperBound;
    private double bidIncrement;
    private double nextBidLowerBound;

    // Constructors
    public AutoBidderInfo() {
    }

    public AutoBidderInfo(String email, int auctionId, double upperBound, double bidIncrement) {
    	this.name = name;
    	this.email = email;
        this.auctionId = auctionId;
        this.startingCost = startingCost;
        this.currentPrice= currentPrice;
        this.latestBidBy = latestBidBy;
        this.upperBound = upperBound;
        this.bidIncrement = bidIncrement;
        this.nextBidLowerBound = nextBidLowerBound;
    }

    // Getters and Setters
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getAuctionId() {
        return auctionId;
    }

    public void setAuctionId(int auctionId) {
        this.auctionId = auctionId;
    }
    
    public double getStartingCost() {
        return startingCost;
    }

    public void setStartingCost(double startingCost) {
        this.startingCost = startingCost;
    }
    
    public double getCurrentPrice() {
        return currentPrice;
    }

    public void setCurrentPrice(double currentPrice) {
        this.currentPrice = currentPrice;
    }
    
    public String getLatestBidBy() {
        return latestBidBy;
    }

    public void setLatestBidBy(String latestBidBy) {
        this.latestBidBy = latestBidBy;
    }

    public double getUpperBound() {
        return upperBound;
    }

    public void setUpperBound(double upperBound) {
        this.upperBound = upperBound;
    }

    public double getBidIncrement() {
        return bidIncrement;
    }

    public void setBidIncrement(double bidIncrement) {
        this.bidIncrement = bidIncrement;
    }
    
    public double getNextBidLowerBound() {
        return nextBidLowerBound;
    }

    public void setNextBidLowerBound(double nextBidLowerBound) {
        this.nextBidLowerBound = nextBidLowerBound;
    }
}
