package ba.ibu.edu.dao;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.aggregation.Aggregation;
import org.springframework.data.mongodb.core.aggregation.AggregationResults;
import org.springframework.data.mongodb.core.aggregation.Fields;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;

import ba.ibu.edu.helper.HeatMapResponse;
import ba.ibu.edu.helper.StringIntMap;
import ba.ibu.edu.model.Categorized;
import ba.ibu.edu.model.Category;
import ba.ibu.edu.model.DateAggregation;
import ba.ibu.edu.model.DayAggregation;
import ba.ibu.edu.model.Person;

@Repository
public class StatisticsRepository {

	@Autowired
	private MongoTemplate mongoTemplate;

	public List<Categorized> statisiticsPerCategoryByUserId(String userId) {
		Aggregation agg = Aggregation.newAggregation(
				Aggregation.match(Criteria.where("user_id").is(userId)), 
				Aggregation.unwind("categoryId"), 
				Aggregation.group("categoryId").count().as("y"), 
				Aggregation.project("y").and("name").previousOperation());

		AggregationResults<Categorized> result = mongoTemplate.aggregate(agg, "categorizedfeeds", Categorized.class);
		List<Categorized> toRet = result.getMappedResults();

		Query query = new Query();
		query.addCriteria(Criteria.where("_id").is(userId).and("categories.categoryStatus").is(1).and("categories").elemMatch(Criteria.where("categoryStatus").is(1)));
		Person user = mongoTemplate.findOne(query, Person.class);
		Category category;
		Iterator<Category> categoryIterator;
		List<Categorized> categorized = new ArrayList<>();
		for (Categorized c : toRet) {
			categoryIterator = user.getCategories().iterator();
			while (categoryIterator.hasNext()) {
				category = categoryIterator.next();
				if (category.getCategoryId().equals(c.name) && category.getCategoryStatus() == 1) {
					categorized.add(new Categorized(category.getCategoryName(), c.y));
				}
			}

		}
		return categorized;
	}
	
	public List<Categorized> statisiticsPerCategoryByDate(String userId, String categoryId){
		Aggregation agg = Aggregation.newAggregation
						(Aggregation.match(Criteria.where("user_id").is(userId)),
						Aggregation.unwind("categoryId"),
						Aggregation.match(Criteria.where("categoryId").is(categoryId)),
						//Aggregation.limit(50000),
						Aggregation.project("dateOfCreation").andExpression("year(dateOfCreation)").as("year")
															.andExpression("month(dateOfCreation)").as("month")
															.andExpression("dayOfMonth(dateOfCreation)").as("day"),
						Aggregation.group(Fields.fields().and("day").and("month").and("year")).count().as("count"),
						Aggregation.sort(Direction.DESC,"year").and(Direction.DESC,"month").and(Direction.DESC,"day")
						);
		AggregationResults<DateAggregation> result = mongoTemplate.aggregate(agg, "categorizedfeeds", DateAggregation.class);
		List<DateAggregation> aggregationResponse = result.getMappedResults();
		List<Categorized> dateAggregation = new ArrayList<Categorized>();
		for(DateAggregation date : aggregationResponse){
			dateAggregation.add(new Categorized(date.day + "-" + date.month + "-" + date.year, date.count));
		}
		return dateAggregation;
	}
	
	public List<DayAggregation> statisticsPerWeekDay(){
		Aggregation aggregate = Aggregation.newAggregation(
				Aggregation.project("dateOfCreation").and("dateOfCreation").extractDayOfWeek().as("day"),
				//Aggregation.limit(50000),
				Aggregation.group("day").count().as("occurences"),
				Aggregation.project("occurences").and("day").previousOperation(),
				Aggregation.sort(Direction.ASC, "day")
				);
		System.out.println(aggregate.toString());
		AggregationResults<DayAggregation> result = mongoTemplate.aggregate(aggregate, "categorizedfeeds", DayAggregation.class);
		List<DayAggregation> aggregationResponse = result.getMappedResults();
		return aggregationResponse;
	}
	
	public List<DayAggregation> statisticsPerDayHour(){
		Aggregation aggregate = Aggregation.newAggregation(
				Aggregation.project("dateOfCreation").and("dateOfCreation").extractHour().as("hour"),
				//Aggregation.limit(10000),
				Aggregation.group("hour").count().as("occurences"),
				Aggregation.project("occurences").and("hour").previousOperation(),
				Aggregation.sort(Direction.ASC, "hour")
				//,Aggregation.limit(50000)
				);
		AggregationResults<DayAggregation> result = mongoTemplate.aggregate(aggregate, "categorizedfeeds", DayAggregation.class);
		List<DayAggregation> aggregationResponse = result.getMappedResults();
		return aggregationResponse;
	}
	
	public List<StringIntMap> statisticsPerCriteria(){
		Aggregation aggregate = Aggregation.newAggregation(
				Aggregation.unwind("criteriaId"),
				Aggregation.group("criteriId").count().as("occurences"),
				Aggregation.project("occurences").and("criteriId").previousOperation(),
				Aggregation.sort(Direction.ASC, "occurences")
				//,Aggregation.limit(10)
				);
		
		AggregationResults<StringIntMap> result = mongoTemplate.aggregate(aggregate, "categorizedfeeds", StringIntMap.class);
		List<StringIntMap> aggregationResponse = result.getMappedResults();
		return aggregationResponse;
	}
	
	public List<HeatMapResponse> statisticsForHeatMap(){
		Aggregation aggregate = Aggregation.newAggregation(
					//Aggregation.match(Criteria.where("dateOfCreation").gt(sdate).lt(edate)),
					Aggregation.project("dateOfCreation").and("dateOfCreation").extractDayOfWeek().as("day").and("dateOfCreation").extractHour().as("hour"),
					Aggregation.group(Fields.fields("day","hour")).count().as("occurences"),
					Aggregation.sort(Direction.ASC, "_id.hour").and(Direction.ASC, "_id.day")
				);
		System.out.println("QUERY ## " + aggregate.toString());
		AggregationResults<HeatMapResponse> result = mongoTemplate.aggregate(aggregate, "categorizedfeeds", HeatMapResponse.class);
		List<HeatMapResponse> aggregationResponse = result.getMappedResults();
		return aggregationResponse;
		
	}
	
	public List<HeatMapResponse> statisticsForEachCategoryByDate(String userId){
		Aggregation aggregate = Aggregation.newAggregation(
				Aggregation.match(Criteria.where("user_id").is(userId)),
				Aggregation.unwind("categoryId"),
				Aggregation.project("categoryId").and("dateOfCreation").extractYear().as("year")
												 .and("dateOfCreation").extractMonth().as("month")
												 .and("dateOfCreation").extractDayOfMonth().as("day"),
				Aggregation.group(Fields.fields("year","month","day","categoryId")).count().as("occurences"),
				Aggregation.group(Fields.fields("_id.year","_id.month","_id.day")).push("_id.categoryId").as("categories").push("occurences").as("categoryOccurences"),
				Aggregation.sort(Direction.DESC, "_id.year", "_id.month", "_id.day")
				//,Aggregation.limit(20)
				);
		System.out.println("QUERY ## " + aggregate.toString());
		AggregationResults<HeatMapResponse> result = mongoTemplate.aggregate(aggregate, "categorizedfeeds", HeatMapResponse.class);
		List<HeatMapResponse> aggregationResponse = result.getMappedResults();
		return aggregationResponse;
		
	}
	
	//All categories impl. goes here
	public List<StringIntMap> statisticsForAllCategories(){
		Aggregation aggregate = Aggregation.newAggregation(
				Aggregation.unwind("criteriaId"),
				Aggregation.group("criteriId").count().as("occurences"),
				Aggregation.project("occurences").and("criteriId").previousOperation(),
				Aggregation.sort(Direction.ASC, "occurences")
				//,Aggregation.limit(10)
				);
		
		AggregationResults<StringIntMap> result = mongoTemplate.aggregate(aggregate, "categorizedfeeds", StringIntMap.class);
		List<StringIntMap> aggregationResponse = result.getMappedResults();
		return aggregationResponse;
	}
	
}

