package controllers

import (
	"mcs_bab_6/database"
	"mcs_bab_6/entities"
	"mcs_bab_6/repositories"
	"net/http"

	"github.com/gin-gonic/gin"
)

func GetCards(c *gin.Context) {
	var result gin.H

	card, err := repositories.GetCards(database.DbConnection)

	if err != nil {
		result = gin.H{
			"result": err.Error(),
		}
	} else {
		result = gin.H{
			"result": card,
		}
	}

	c.JSON(http.StatusOK, result)
}

func InsertCard(c *gin.Context) {
	var card entities.Card
	idCard := c.Param("id")
	card.ID = idCard

	err := repositories.InsertCard(database.DbConnection, card)

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"errpr": err.Error()})
		return
	}

	c.JSON(http.StatusOK, card)
}

func DeleteCard(c *gin.Context) {
	var card entities.Card
	idCard := c.Param("id")
	card.ID = idCard

	err := repositories.DeleteCard(database.DbConnection, card)

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
	}

	c.JSON(http.StatusOK, gin.H{"message": "Data berhasil dihapus", "id": idCard})
}
