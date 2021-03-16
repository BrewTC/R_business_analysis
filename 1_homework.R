{
  "nbformat": 4,
  "nbformat_minor": 0,
  "metadata": {
    "colab": {
      "name": "1 homework.R",
      "provenance": [],
      "collapsed_sections": [],
      "authorship_tag": "ABX9TyMYaz3nIi4JEicmcTWzTSqb",
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
        "<a href=\"https://colab.research.google.com/github/BrewTC/R_business_analysis/blob/main/1_homework.R\" target=\"_parent\"><img src=\"https://colab.research.google.com/assets/colab-badge.svg\" alt=\"Open In Colab\"/></a>"
      ]
    },
    {
      "cell_type": "code",
      "metadata": {
        "id": "1Pxd7Lp4xUgA"
      },
      "source": [
        "詳細的作業說明，請見「Ch 1.1 - R 語言基礎 -  R 語言的資料型態」。本次作業的目標是：綜合使用使用者自訂函數、流程控制、迴圈控制等方法，進行 R 語言統計分析。我們會在繳交完作業後，傳送正確答案給你！\r\n",
        "\r\n",
        "作業題目\r\n",
        "\r\n",
        "請大家試著綜合上述所學，練習進行 iris 資料集合的統計分析：\r\n",
        "\r\n",
        "試圖撰寫函數 SummarizeData(data.frame)： \r\n",
        "- 輸入：名為 data.frame 的資料框架，該函數將計算計算 data.frame 的統計量 0    \r\n",
        "- 輸出：名為 `output` 的資料框架，`output`  columns 的值依序為 `data.frame` 每個 column 的平均數（`mean`）、變異數（`var`）、最大值（`max`）、最小值（`min`），每個 row 是 `data.frame` 的一個 column \r\n",
        "利用這個函數，計算 iris 資料集合前四個 columns 的各項統計量。\r\n",
        "\r\n",
        "定義第 i 朵花與第 j 朵花的差異程度為兩朵花資料的歐式距離 (Euclidean distance)，其中 xik 代表第 i 朵花在 iris資料集合中第 k 個變數的數值。試著用 for 迴圈建立一個 150 x 150 的矩陣 A，其中 Aij=d(i,j)。\r\n"
      ],
      "execution_count": null,
      "outputs": []
    },
    {
      "cell_type": "code",
      "metadata": {
        "id": "0zS8JMjcz8lJ"
      },
      "source": [
        "#問題1:(自訂函數與 for 迴圈)\r\n",
        "SummarizeData <- function(x){\r\n",
        "\r\n",
        "  output <- data.frame(x_mean = mean(x),\r\n",
        "            x_var = var(x),\r\n",
        "            x_max = max(x),\r\n",
        "            x_min = min(x))\r\n",
        "  return(output)\r\n",
        "}\r\n",
        "SummarizeData(iris[,1])\r\n",
        "SummarizeData(iris[,2])\r\n",
        "SummarizeData(iris[,3])\r\n",
        "SummarizeData(iris[,4])\r\n",
        "\r\n",
        "#問題2:(巢狀 for 迴圈)\r\n",
        "A -> matrix(0,nrow=150,ncol=150)\r\n",
        "for (i in 1:150) {\r\n",
        "    for (j in 1:150){\r\n",
        "        for (k in 1:4){\r\n",
        "            A[i,j] <- A[i,j]+(iris[i,k] - iris[j, k])^2\r\n",
        "        }\r\n",
        "    }\r\n",
        "}\r\n",
        "sqrt(A)"
      ],
      "execution_count": null,
      "outputs": []
    }
  ]
}