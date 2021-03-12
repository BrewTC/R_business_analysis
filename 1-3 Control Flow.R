{
  "nbformat": 4,
  "nbformat_minor": 0,
  "metadata": {
    "colab": {
      "name": "1-3 Control Flow.R",
      "provenance": [],
      "authorship_tag": "ABX9TyPLJ8Kv7X7J/pJsJg8ZI/XP",
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
        "<a href=\"https://colab.research.google.com/github/BrewTC/R_business_analysis/blob/main/1-3%20Control%20Flow.R\" target=\"_parent\"><img src=\"https://colab.research.google.com/assets/colab-badge.svg\" alt=\"Open In Colab\"/></a>"
      ]
    },
    {
      "cell_type": "code",
      "metadata": {
        "id": "akmf4knuoRNl"
      },
      "source": [
        "# Boolean Operator\r\n",
        "3 > 5\r\n",
        "#[1] FALSE\r\n",
        "6 > 5\r\n",
        "#[1] TRUE\r\n",
        "\r\n",
        "# And\r\n",
        "#&每一個元素個別做比較\r\n",
        "#&&只要有一個不滿足就會輸出FALSE\r\n",
        "set.seed(0)\r\n",
        "x <- runif(8, -1, 1)\r\n",
        "x\r\n",
        "0 <= x & x <= 0.5 # Elementwise AND\r\n",
        "0 <= x && x <= 0.5 # Lazy AND\r\n",
        "x[0 <= x & x <= 0.5] <- 999 # Elementwise AND\r\n",
        "x\r\n",
        "\r\n",
        "# Or\r\n",
        "#|每一個元素個別做比較\r\n",
        "#||只要有一個滿足就會輸出TRUE\r\n",
        "x <- runif(8, -1, 1)\r\n",
        "x\r\n",
        "\r\n",
        "-0.5 >= x | x >= 0.5 # Elementwise OR\r\n",
        "-0.5 >= x || x >= 0.5 # Lazy AND\r\n",
        "x[-0.5 >= x | x >= 0.5] <- 999 # Elementwise AND\r\n",
        "x\r\n",
        "\r\n",
        "# If and Else\r\n",
        "x <- 1\r\n",
        "if (x > 0) {\r\n",
        "  y <- 5\r\n",
        "} else {\r\n",
        "  y <- 10\r\n",
        "}\r\n",
        "y \r\n",
        "#[1] 5\r\n",
        "\r\n",
        "# ifelse function\r\n",
        "#ifelse(x > 0, if, else)\r\n",
        "y <- ifelse(x > 0, 5, 10)\r\n",
        "y \r\n",
        "#[1] 5\r\n",
        "\r\n",
        "# Switch\r\n",
        "switch(\"first\", first = 1 + 1, second = 1 + 2, third = 1 + 3)\r\n",
        "#[1] 2\r\n",
        "switch(\"second\", first = 1 + 1, second = 1 + 2, third = 1 + 3)\r\n",
        "#[1] 3\r\n",
        "switch(\"third\", first = 1 + 1, second = 1 + 2, third = 1 + 3)\r\n",
        "#[1] 4\r\n"
      ],
      "execution_count": null,
      "outputs": []
    }
  ]
}