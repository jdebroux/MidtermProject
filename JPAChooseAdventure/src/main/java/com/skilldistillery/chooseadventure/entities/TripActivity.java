package com.skilldistillery.chooseadventure.entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="trip_activity")
public class TripActivity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
//	@ManyToOne
//	@JoinColumn(name="national_park_activity_id")
//	private NationalParkActivity nationalParkActivity;
	
	@ManyToOne
	@JoinColumn(name="trip_id")
	private Trip trip;
	
	@ManyToOne
	@JoinColumn(name="activity_id")
	private Activity activity;

	public TripActivity() {
	}

	public int getId() {
		return id;
	}
	
	
	
//	public NationalParkActivity getNationalParkActivity() {
//		return nationalParkActivity;
//	}
//
//	public void setNationalParkActivity(NationalParkActivity nationalParkActivity) {
//		this.nationalParkActivity = nationalParkActivity;
//	}

	public TripActivity(Activity activity) {
		this.activity = activity;
	}

	public Activity getActivity() {
		return activity;
	}

	public void setActivity(Activity activity) {
		this.activity = activity;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Trip getTrip() {
		return trip;
	}

	public void setTrip(Trip trip) {
		this.trip = trip;
	}

//	@Override
//	public int hashCode() {
//		final int prime = 31;
//		int result = 1;
//		result = prime * result + id;
//		return result;
//	}
//
//	@Override
//	public boolean equals(Object obj) {
//		if (this == obj)
//			return true;
//		if (obj == null)
//			return false;
//		if (getClass() != obj.getClass())
//			return false;
//		TripActivity other = (TripActivity) obj;
//		if (id != other.id)
//			return false;
//		return true;
//	}

	@Override
	public String toString() {
		return "TripActivity [id=" + id + "]";
	}
}
