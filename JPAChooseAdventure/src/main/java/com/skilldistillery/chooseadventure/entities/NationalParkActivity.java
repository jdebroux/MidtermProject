package com.skilldistillery.chooseadventure.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

@Entity
public class NationalParkActivity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(name = "national_park_id")
	private int nationalParkId;
	
	@Column(name = "activity_id")
	private int activityId;
	
	@ManyToOne
	@JoinColumn(name="activity_id")
	private Activity activity;
	
	@ManyToOne
	@JoinColumn(name="national_park_id")
	private NationalPark nationalPark;
	
	@OneToMany(mappedBy="nationalParkActivity")
	private TripActivity tripActivity;

	public NationalParkActivity() {
	}

	public NationalParkActivity(int nationalParkId, int activityId) {
		this.nationalParkId = nationalParkId;
		this.activityId = activityId;
	}

	public int getNationalParkId() {
		return nationalParkId;
	}

	public void setNationalParkId(int nationalParkId) {
		this.nationalParkId = nationalParkId;
	}

	public int getActivityId() {
		return activityId;
	}

	public void setActivityId(int activityId) {
		this.activityId = activityId;
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

	public TripActivity getTripActivity() {
		return tripActivity;
	}

	public void setTripActivity(TripActivity tripActivity) {
		this.tripActivity = tripActivity;
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
