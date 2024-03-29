package com.skilldistillery.chooseadventure.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;

@Entity
public class Activity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	@Column(name = "link_wiki")
	private String link;
	
	@OneToMany(mappedBy="activity")
	private List<NationalParkActivity> nationalParkActivities;
	
	@ManyToMany(cascade= {CascadeType.PERSIST, CascadeType.REMOVE})
	@JoinTable(name="national_park_activity", joinColumns=@JoinColumn(name="activity_id"),
	inverseJoinColumns=@JoinColumn(name="national_park_id"))
	private List<NationalPark> nationalParks;	
	
	@ManyToMany(cascade= {CascadeType.PERSIST, CascadeType.REMOVE})
	@JoinTable(name="trip_activity", joinColumns=@JoinColumn(name="activity_id"),
	inverseJoinColumns=@JoinColumn(name="trip_id"))
	private List<Trip> trips;	

	@OneToMany(mappedBy = "activity")
	private List<TripActivity> tripActivities;
	
	public Activity() {
	}
	
	public Activity(int id) {
		this.id = id;
	}

	public Activity(String name, String link) {
		this.name = name;
		this.link = link;
	}
	
	public void addNationalPark(NationalPark nationalPark) {
		if(nationalParks == null) {
			nationalParks = new ArrayList<>();
		}
		if(!nationalParks.contains(nationalPark)) {
			nationalParks.add(nationalPark);
			nationalPark.addActivity(this);
		}
	}
	
	public void removeNationalPark(NationalPark nationalPark) {
		if(nationalParks != null && nationalParks.contains(nationalPark)) {
			nationalParks.remove(nationalPark);
			nationalPark.removeActivity(this);
		}
	}
	
	public void addTrip(Trip trip) {
		if(trips == null) {
			trips = new ArrayList<>();
		}
		if(!trips.contains(trip)) {
			trips.add(trip);
			trip.addActivity(this);
		}
	}
	
	public void removeTrip(Trip trip) {
		if(trips != null && trips.contains(trip)) {
			trips.remove(trip);
			trip.removeActivity(this);
		}
	}
	
	public void addNationalParkActivity(NationalParkActivity nationalParkActivity) {
		if(nationalParkActivities == null) nationalParkActivities = new ArrayList<>();
		
		if(!nationalParkActivities.contains(nationalParkActivity)) {
			nationalParkActivities.add(nationalParkActivity);
			if(nationalParkActivity.getActivity() != null) {
				nationalParkActivity.getActivity().getNationalParkActivities().remove(nationalParkActivity);
			}
			nationalParkActivity.setActivity(this);
		}
	}
	
	public void removeNationalParkActivity(NationalParkActivity nationalParkActivity) {
		nationalParkActivity.setActivity(null);
		if(nationalParkActivities != null) {
			nationalParkActivities.remove(nationalParkActivity);
		}
	}
	
	

	public List<TripActivity> getTripActivities() {
		return new ArrayList<>(tripActivities);
	}

	public void setTripActivities(List<TripActivity> tripActivities) {
		this.tripActivities = tripActivities;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public int getId() {
		return id;
	}
	
	public List<NationalPark> getNationalParks() {
		return nationalParks;
	}

	public void setNationalParks(List<NationalPark> nationalParks) {
		this.nationalParks = nationalParks;
	}

	public List<Trip> getTrips() {
		return trips;
	}

	public void setTrips(List<Trip> trips) {
		this.trips = trips;
	}

	public void setId(int id) {
		this.id = id;
	}

	public List<NationalParkActivity> getNationalParkActivities() {
		return new ArrayList<>(nationalParkActivities);
	}

	public void setNationalParkActivities(List<NationalParkActivity> nationalParkActivities) {
		this.nationalParkActivities = nationalParkActivities;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Activity other = (Activity) obj;
		if (id != other.id)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Activity [id=" + id + ", name=" + name + "]";
	}
}
