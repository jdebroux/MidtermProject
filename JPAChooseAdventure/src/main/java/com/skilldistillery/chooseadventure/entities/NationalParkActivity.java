package com.skilldistillery.chooseadventure.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="national_park_activity")
public class NationalParkActivity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@ManyToOne
	@JoinColumn(name="activity_id")
	private Activity activity;
	
	@ManyToOne
	@JoinColumn(name="national_park_id")
	private NationalPark nationalPark;
	
	@OneToMany(mappedBy="nationalParkActivity")
	private List<TripActivity> tripActivities;

	public NationalParkActivity() {
	}
	
	public void addTripActivity(TripActivity tripActivity) {
		if(tripActivities == null) tripActivities = new ArrayList<>();
		
		if(!tripActivities.contains(tripActivity)) {
			tripActivities.add(tripActivity);
			if(tripActivity.getNationalParkActivity() != null) {
				tripActivity.getNationalParkActivity().getTripActivities().remove(tripActivity);
			}
			tripActivity.setNationalParkActivity(this);
		}
	}
	
	public void removeTripActivity(TripActivity tripActivity) {
		tripActivity.setNationalParkActivity(null);
		if(tripActivities != null) {
			tripActivities.remove(tripActivity);
		}
	}

	public int getId() {
		return id;
	}
	
	public Activity getActivity() {
		return activity;
	}

	public void setActivity(Activity activity) {
		this.activity = activity;
	}

	public NationalPark getNationalPark() {
		return nationalPark;
	}

	public void setNationalPark(NationalPark nationalPark) {
		this.nationalPark = nationalPark;
	}

	public List<TripActivity> getTripActivities() {
		return new ArrayList<>(tripActivities);
	}

	public void setTripActivities(List<TripActivity> tripActivities) {
		this.tripActivities = tripActivities;
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
		NationalParkActivity other = (NationalParkActivity) obj;
		if (id != other.id)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "NationalParkActivity [id=" + id + "]";
	}
}
