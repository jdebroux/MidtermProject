package com.skilldistillery.chooseadventure.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

@Entity
public class Trip {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String name;

	@OneToMany(mappedBy = "trip", cascade= {CascadeType.PERSIST})
	private List<TripActivity> tripActivities;

	@OneToMany(mappedBy = "trip")
	private List<TripComment> tripComments;

	@ManyToOne
	@JoinColumn(name = "national_park_id")
	private NationalPark nationalPark;

	@ManyToOne
	@JoinColumn(name = "account_id")
	private Account account;

	@ManyToMany(mappedBy = "trips", fetch=FetchType.EAGER, cascade= {CascadeType.PERSIST})
	private List<Activity> activities = new ArrayList<>();

	public Trip() {
	}

	public Trip(String name) {
		this.name = name;
	}

	public void addActivity(Activity activity) {
		if (activities == null) {
			activities = new ArrayList<>();
		}
		if (!activities.contains(activity)) {
			activities.add(activity);
			activity.addTrip(this);
		}
	}

	public void removeActivity(Activity activity) {
		if (activities != null && activities.contains(activity)) {
			activities.remove(activity);
			activity.removeTrip(this);
		}
	}
	
	public void addTripActivity(TripActivity tripActivity) {
		if (tripActivities == null) {
			tripActivities = new ArrayList<>();
		}
		if (!tripActivities.contains(tripActivity)) {
			tripActivities.add(tripActivity);
			tripActivity.setTrip(this);
		}
	}
	
	public void removeTripActivity(TripActivity tripActivity) {
		if (tripActivities != null && tripActivities.contains(tripActivity)) {
			tripActivities.remove(tripActivity);
			tripActivity.setTrip(null);
		}
	}

	public void addTripComment(TripComment tripComment) {
		if (tripComments == null)
			tripComments = new ArrayList<>();

		if (!tripComments.contains(tripComment)) {
			tripComments.add(tripComment);
			if (tripComment.getTrip() != null) {
				tripComment.getTrip().getTripComments().remove(tripComment);
			}
			tripComment.setTrip(this);
		}
	}

	public void removeTrip(TripComment tripComment) {
		tripComment.setTrip(null);
		if (tripComments != null) {
			tripComments.remove(tripComment);
		}
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getId() {
		return id;
	}

	public List<TripActivity> getTripActivities() {
		return new ArrayList<>(tripActivities);
	}

	public void setTripActivities(List<TripActivity> tripActivities) {
		this.tripActivities = tripActivities;
	}

	public List<TripComment> getTripComments() {
		return new ArrayList<>(tripComments);
	}

	public void setTripComments(List<TripComment> tripComments) {
		this.tripComments = tripComments;
	}

	public NationalPark getNationalPark() {
		return nationalPark;
	}

	public void setNationalPark(NationalPark nationalPark) {
		this.nationalPark = nationalPark;
	}

	public Account getAccount() {
		return account;
	}

	public void setAccount(Account account) {
		this.account = account;
	}

	public List<Activity> getActivities() {
		return new ArrayList<>(activities);
	}

	public void setActivities(List<Activity> activities) {
		this.activities = activities;
	}

	public void setId(int id) {
		this.id = id;
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
		Trip other = (Trip) obj;
		if (id != other.id)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Trip [id=" + id + ", name=" + name + ", nationalPark=" + nationalPark + ", account=" + account + "]";
	}
}