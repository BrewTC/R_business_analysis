{
  "nbformat": 4,
  "nbformat_minor": 0,
  "metadata": {
    "colab": {
      "name": "1-4 Loop.R",
      "provenance": [],
      "collapsed_sections": [],
      "authorship_tag": "ABX9TyNI2im1A+Y5iHf/dCNw+iyY",
      "include_colab_link": true
    },
    "kernelspec": {
      "name": "python3",
      "display_name": "Python 3"
    }
  },
  "cells": [
    {
      "cell_type": "markdown",
      "metadata": {
        "id": "view-in-github",
        "colab_type": "text"
      },
      "source": [
        "<a href=\"https://colab.research.google.com/github/BrewTC/R_business_analysis/blob/main/1-4%20Loop.R\" target=\"_parent\"><img src=\"https://colab.research.google.com/assets/colab-badge.svg\" alt=\"Open In Colab\"/></a>"
      ]
    },
    {
      "cell_type": "code",
      "metadata": {
        "id": "ilYDuBYHpAOF"
      },
      "source": [
        "# For-loop Intro\r\n",
        "#cat()輸出結果\r\n",
        "for (i in 1:5) {\r\n",
        "  cat(i)\r\n",
        "}\r\n",
        "#12345\r\n",
        "\r\n",
        "for (str in c(\"R\", \"Business\", \"Analiytics\")) {\r\n",
        "  cat(paste(str, \"is super interesting!\\n\"))\r\n",
        "}\r\n",
        "#R is super interesting!\r\n",
        "#Business is super interesting!\r\n",
        "#Analiytics is super interesting!\r\n",
        "\r\n",
        "# For loop for vector updating\r\n",
        "n <- 10\r\n",
        "sum.vec <- rep(1, n)\r\n",
        "\r\n",
        "for (i in 2:n) {\r\n",
        "  sum.vec[i] <- sum.vec[i - 1] + i\r\n",
        "}\r\n",
        "\r\n",
        "sum.vec\r\n",
        "#[1]  1  3  6 10 15 21 28 36 45 55\r\n",
        "\r\n",
        "# Break out a for loop\r\n",
        "n <- 10\r\n",
        "sum.vec <- rep(1, n)\r\n",
        "\r\n",
        "for (i in 2:n) {\r\n",
        "  sum.vec[i] <- sum.vec[i - 1] + i\r\n",
        "  if (sum.vec[i] > 10) {\r\n",
        "    cat(\"I'm outta here. I don't like numbers bigger than 10\\n\")\r\n",
        "    break\r\n",
        "  }\r\n",
        "}\r\n",
        "\r\n",
        "sum.vec\r\n",
        "\r\n",
        "# Nested for loop\r\n",
        "#巢狀for迴圈\r\n",
        "for (i in 1:4) {\r\n",
        "  for (j in 1:4) {\r\n",
        "    cat(paste(\"(\", i, \",\", j, \")  \"))\r\n",
        "  }\r\n",
        "  cat(\"\\n\")\r\n",
        "}\r\n",
        "\r\n",
        "for (i in 1:4) {\r\n",
        "  for (j in 1:i^2) {\r\n",
        "    cat(paste(j,\"\"))\r\n",
        "  }\r\n",
        "  cat(\"\\n\")\r\n",
        "}\r\n",
        "\r\n",
        "# While loop\r\n",
        "i <- 1\r\n",
        "\r\n",
        "while(i < 5) {\r\n",
        "  i <- i + 1\r\n",
        "  cat(paste(i, \"\\n\"))\r\n",
        "}\r\n",
        "\r\n",
        "# Repeated loop\r\n",
        "repeat {\r\n",
        "  ans = readline(\"Who is the most handsome guy? \")\r\n",
        "  if (ans == \"David\") {\r\n",
        "    cat(\"Yes! You get an 'A'.\")\r\n",
        "    break\r\n",
        "  }\r\n",
        "  else {\r\n",
        "    cat(\"Wrong answer!\\n\")\r\n",
        "  } \r\n",
        "}"
      ],
      "execution_count": null,
      "outputs": []
    }
  ]
}