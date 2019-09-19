package com.skilldistillery.chooseadventure.entities;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="trip_comment")
public class TripComment {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String title;
	
	private String description;
	
	private int completed;
	
	@Column(name = "create_date")
	private Date createDate;
	
	@ManyToOne
	@JoinColumn(name="trip_id")
	private Trip trip;

	public TripComment() {
	}

	public TripComment(String title, Date createDate, String description) {
		this.title = title;
		this.createDate = createDate;
		this.description = description;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getId() {
		return id;
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
		TripComment other = (TripComment) obj;
		if (id != other.id)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "TripComment [id=" + id + ", title=" + title + ", createDate=" + createDate
				+ ", description=" + description + "]";
	}
}
