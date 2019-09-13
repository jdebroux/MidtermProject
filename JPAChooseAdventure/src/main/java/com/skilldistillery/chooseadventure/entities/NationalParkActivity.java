package com.skilldistillery.chooseadventure.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class NationalParkActivity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@Column(name = "national_park_id")
	private int nationalParkId;
	@Column(name = "activity_id")
	private int activityId;

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
		return "NationalParkActivity [id=" + id + ", nationalParkId=" + nationalParkId + ", activityId=" + activityId
				+ "]";
	}
}
