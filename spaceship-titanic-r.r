{
 "cells": [
  {
   "cell_type": "markdown",
   "id": "96556dd4",
   "metadata": {
    "papermill": {
     "duration": 0.005206,
     "end_time": "2022-12-19T20:12:08.139901",
     "exception": false,
     "start_time": "2022-12-19T20:12:08.134695",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "https://stats.oarc.ucla.edu/r/dae/logit-regression/"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "f7c547b8",
   "metadata": {
    "_execution_state": "idle",
    "_uuid": "051d70d956493feee0c6d64651c6a088724dca2a",
    "execution": {
     "iopub.execute_input": "2022-12-19T20:12:08.152051Z",
     "iopub.status.busy": "2022-12-19T20:12:08.150282Z",
     "iopub.status.idle": "2022-12-19T20:12:09.420860Z",
     "shell.execute_reply": "2022-12-19T20:12:09.419371Z"
    },
    "papermill": {
     "duration": 1.279767,
     "end_time": "2022-12-19T20:12:09.423928",
     "exception": false,
     "start_time": "2022-12-19T20:12:08.144161",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\n",
      "Attaching package: ‘dplyr’\n",
      "\n",
      "\n",
      "The following objects are masked from ‘package:stats’:\n",
      "\n",
      "    filter, lag\n",
      "\n",
      "\n",
      "The following objects are masked from ‘package:base’:\n",
      "\n",
      "    intersect, setdiff, setequal, union\n",
      "\n",
      "\n",
      "Loading required package: ggplot2\n",
      "\n",
      "Loading required package: ggstance\n",
      "\n",
      "\n",
      "Attaching package: ‘ggstance’\n",
      "\n",
      "\n",
      "The following objects are masked from ‘package:ggplot2’:\n",
      "\n",
      "    geom_errorbarh, GeomErrorbarh\n",
      "\n",
      "\n",
      "Loading required package: scales\n",
      "\n",
      "\n",
      "Attaching package: ‘scales’\n",
      "\n",
      "\n",
      "The following object is masked from ‘package:readr’:\n",
      "\n",
      "    col_factor\n",
      "\n",
      "\n",
      "Loading required package: ggridges\n",
      "\n",
      "\n",
      "New to ggformula?  Try the tutorials: \n",
      "\tlearnr::run_tutorial(\"introduction\", package = \"ggformula\")\n",
      "\tlearnr::run_tutorial(\"refining\", package = \"ggformula\")\n",
      "\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "'spaceship-titanic'"
      ],
      "text/latex": [
       "'spaceship-titanic'"
      ],
      "text/markdown": [
       "'spaceship-titanic'"
      ],
      "text/plain": [
       "[1] \"spaceship-titanic\""
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# This R environment comes with many helpful analytics packages installed\n",
    "# It is defined by the kaggle/rstats Docker image: https://github.com/kaggle/docker-rstats\n",
    "# For example, here's a helpful package to load\n",
    "\n",
    "library(readr)\n",
    "library(dplyr)\n",
    "library(ggformula)\n",
    "library(tidyr)\n",
    "library(stringr)\n",
    "library(aod)\n",
    "\n",
    "# Input data files are available in the read-only \"../input/\" directory\n",
    "# For example, running this (by clicking run or pressing Shift+Enter) will list all files under the input directory\n",
    "\n",
    "list.files(path = \"../input\")\n",
    "\n",
    "# You can write up to 20GB to the current directory (/kaggle/working/) that gets preserved as output when you create a version using \"Save & Run All\" \n",
    "# You can also write temporary files to /kaggle/temp/, but they won't be saved outside of the current session"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "1e815e86",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-12-19T20:12:09.464995Z",
     "iopub.status.busy": "2022-12-19T20:12:09.436024Z",
     "iopub.status.idle": "2022-12-19T20:12:09.539543Z",
     "shell.execute_reply": "2022-12-19T20:12:09.525548Z"
    },
    "papermill": {
     "duration": 0.113062,
     "end_time": "2022-12-19T20:12:09.542219",
     "exception": false,
     "start_time": "2022-12-19T20:12:09.429157",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 13</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>PassengerId</th><th scope=col>HomePlanet</th><th scope=col>CryoSleep</th><th scope=col>Cabin</th><th scope=col>Destination</th><th scope=col>Age</th><th scope=col>VIP</th><th scope=col>RoomService</th><th scope=col>FoodCourt</th><th scope=col>ShoppingMall</th><th scope=col>Spa</th><th scope=col>VRDeck</th><th scope=col>Name</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>0013_01</td><td>Earth </td><td>True </td><td>G/3/S</td><td>TRAPPIST-1e</td><td>27</td><td>False</td><td> 0</td><td>   0</td><td>  0</td><td>   0</td><td>  0</td><td>Nelly Carsoning </td></tr>\n",
       "\t<tr><th scope=row>2</th><td>0018_01</td><td>Earth </td><td>False</td><td>F/4/S</td><td>TRAPPIST-1e</td><td>19</td><td>False</td><td> 0</td><td>   9</td><td>  0</td><td>2823</td><td>  0</td><td>Lerome Peckers  </td></tr>\n",
       "\t<tr><th scope=row>3</th><td>0019_01</td><td>Europa</td><td>True </td><td>C/0/S</td><td>55 Cancri e</td><td>31</td><td>False</td><td> 0</td><td>   0</td><td>  0</td><td>   0</td><td>  0</td><td>Sabih Unhearfus </td></tr>\n",
       "\t<tr><th scope=row>4</th><td>0021_01</td><td>Europa</td><td>False</td><td>C/1/S</td><td>TRAPPIST-1e</td><td>38</td><td>False</td><td> 0</td><td>6652</td><td>  0</td><td> 181</td><td>585</td><td>Meratz Caltilter</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>0023_01</td><td>Earth </td><td>False</td><td>F/5/S</td><td>TRAPPIST-1e</td><td>20</td><td>False</td><td>10</td><td>   0</td><td>635</td><td>   0</td><td>  0</td><td>Brence Harperez </td></tr>\n",
       "\t<tr><th scope=row>6</th><td>0027_01</td><td>Earth </td><td>False</td><td>F/7/P</td><td>TRAPPIST-1e</td><td>31</td><td>False</td><td> 0</td><td>1615</td><td>263</td><td> 113</td><td> 60</td><td>Karlen Ricks    </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 13\n",
       "\\begin{tabular}{r|lllllllllllll}\n",
       "  & PassengerId & HomePlanet & CryoSleep & Cabin & Destination & Age & VIP & RoomService & FoodCourt & ShoppingMall & Spa & VRDeck & Name\\\\\n",
       "  & <chr> & <chr> & <chr> & <chr> & <chr> & <dbl> & <chr> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <chr>\\\\\n",
       "\\hline\n",
       "\t1 & 0013\\_01 & Earth  & True  & G/3/S & TRAPPIST-1e & 27 & False &  0 &    0 &   0 &    0 &   0 & Nelly Carsoning \\\\\n",
       "\t2 & 0018\\_01 & Earth  & False & F/4/S & TRAPPIST-1e & 19 & False &  0 &    9 &   0 & 2823 &   0 & Lerome Peckers  \\\\\n",
       "\t3 & 0019\\_01 & Europa & True  & C/0/S & 55 Cancri e & 31 & False &  0 &    0 &   0 &    0 &   0 & Sabih Unhearfus \\\\\n",
       "\t4 & 0021\\_01 & Europa & False & C/1/S & TRAPPIST-1e & 38 & False &  0 & 6652 &   0 &  181 & 585 & Meratz Caltilter\\\\\n",
       "\t5 & 0023\\_01 & Earth  & False & F/5/S & TRAPPIST-1e & 20 & False & 10 &    0 & 635 &    0 &   0 & Brence Harperez \\\\\n",
       "\t6 & 0027\\_01 & Earth  & False & F/7/P & TRAPPIST-1e & 31 & False &  0 & 1615 & 263 &  113 &  60 & Karlen Ricks    \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 13\n",
       "\n",
       "| <!--/--> | PassengerId &lt;chr&gt; | HomePlanet &lt;chr&gt; | CryoSleep &lt;chr&gt; | Cabin &lt;chr&gt; | Destination &lt;chr&gt; | Age &lt;dbl&gt; | VIP &lt;chr&gt; | RoomService &lt;dbl&gt; | FoodCourt &lt;dbl&gt; | ShoppingMall &lt;dbl&gt; | Spa &lt;dbl&gt; | VRDeck &lt;dbl&gt; | Name &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 0013_01 | Earth  | True  | G/3/S | TRAPPIST-1e | 27 | False |  0 |    0 |   0 |    0 |   0 | Nelly Carsoning  |\n",
       "| 2 | 0018_01 | Earth  | False | F/4/S | TRAPPIST-1e | 19 | False |  0 |    9 |   0 | 2823 |   0 | Lerome Peckers   |\n",
       "| 3 | 0019_01 | Europa | True  | C/0/S | 55 Cancri e | 31 | False |  0 |    0 |   0 |    0 |   0 | Sabih Unhearfus  |\n",
       "| 4 | 0021_01 | Europa | False | C/1/S | TRAPPIST-1e | 38 | False |  0 | 6652 |   0 |  181 | 585 | Meratz Caltilter |\n",
       "| 5 | 0023_01 | Earth  | False | F/5/S | TRAPPIST-1e | 20 | False | 10 |    0 | 635 |    0 |   0 | Brence Harperez  |\n",
       "| 6 | 0027_01 | Earth  | False | F/7/P | TRAPPIST-1e | 31 | False |  0 | 1615 | 263 |  113 |  60 | Karlen Ricks     |\n",
       "\n"
      ],
      "text/plain": [
       "  PassengerId HomePlanet CryoSleep Cabin Destination Age VIP   RoomService\n",
       "1 0013_01     Earth      True      G/3/S TRAPPIST-1e 27  False  0         \n",
       "2 0018_01     Earth      False     F/4/S TRAPPIST-1e 19  False  0         \n",
       "3 0019_01     Europa     True      C/0/S 55 Cancri e 31  False  0         \n",
       "4 0021_01     Europa     False     C/1/S TRAPPIST-1e 38  False  0         \n",
       "5 0023_01     Earth      False     F/5/S TRAPPIST-1e 20  False 10         \n",
       "6 0027_01     Earth      False     F/7/P TRAPPIST-1e 31  False  0         \n",
       "  FoodCourt ShoppingMall Spa  VRDeck Name            \n",
       "1    0        0             0   0    Nelly Carsoning \n",
       "2    9        0          2823   0    Lerome Peckers  \n",
       "3    0        0             0   0    Sabih Unhearfus \n",
       "4 6652        0           181 585    Meratz Caltilter\n",
       "5    0      635             0   0    Brence Harperez \n",
       "6 1615      263           113  60    Karlen Ricks    "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "test_data <- read.csv(\"/kaggle/input/spaceship-titanic/test.csv\")\n",
    "head(test_data)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "5ae5a12a",
   "metadata": {
    "papermill": {
     "duration": 0.005252,
     "end_time": "2022-12-19T20:12:09.552911",
     "exception": false,
     "start_time": "2022-12-19T20:12:09.547659",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Change data types in test_data\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "id": "a36fad9a",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-12-19T20:12:09.566737Z",
     "iopub.status.busy": "2022-12-19T20:12:09.564967Z",
     "iopub.status.idle": "2022-12-19T20:12:09.628328Z",
     "shell.execute_reply": "2022-12-19T20:12:09.626717Z"
    },
    "papermill": {
     "duration": 0.072692,
     "end_time": "2022-12-19T20:12:09.630791",
     "exception": false,
     "start_time": "2022-12-19T20:12:09.558099",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "test_data <- test_data %>%\n",
    "    select(1:ncol(test_data)) %>%\n",
    "    mutate(\n",
    "        CryoSleep = as.logical(CryoSleep),\n",
    "        Cabin = as.factor(Cabin),\n",
    "        VIP = as.logical(VIP)\n",
    "    )\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "id": "520eb4bf",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-12-19T20:12:09.644679Z",
     "iopub.status.busy": "2022-12-19T20:12:09.643202Z",
     "iopub.status.idle": "2022-12-19T20:12:09.658658Z",
     "shell.execute_reply": "2022-12-19T20:12:09.657195Z"
    },
    "papermill": {
     "duration": 0.024421,
     "end_time": "2022-12-19T20:12:09.660606",
     "exception": false,
     "start_time": "2022-12-19T20:12:09.636185",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".dl-inline {width: auto; margin:0; padding: 0}\n",
       ".dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}\n",
       ".dl-inline>dt::after {content: \":\\0020\"; padding-right: .5ex}\n",
       ".dl-inline>dt:not(:first-of-type) {padding-left: .5ex}\n",
       "</style><dl class=dl-inline><dt>PassengerId</dt><dd>'character'</dd><dt>HomePlanet</dt><dd>'character'</dd><dt>CryoSleep</dt><dd>'logical'</dd><dt>Cabin</dt><dd>'factor'</dd><dt>Destination</dt><dd>'character'</dd><dt>Age</dt><dd>'numeric'</dd><dt>VIP</dt><dd>'logical'</dd><dt>RoomService</dt><dd>'numeric'</dd><dt>FoodCourt</dt><dd>'numeric'</dd><dt>ShoppingMall</dt><dd>'numeric'</dd><dt>Spa</dt><dd>'numeric'</dd><dt>VRDeck</dt><dd>'numeric'</dd><dt>Name</dt><dd>'character'</dd></dl>\n"
      ],
      "text/latex": [
       "\\begin{description*}\n",
       "\\item[PassengerId] 'character'\n",
       "\\item[HomePlanet] 'character'\n",
       "\\item[CryoSleep] 'logical'\n",
       "\\item[Cabin] 'factor'\n",
       "\\item[Destination] 'character'\n",
       "\\item[Age] 'numeric'\n",
       "\\item[VIP] 'logical'\n",
       "\\item[RoomService] 'numeric'\n",
       "\\item[FoodCourt] 'numeric'\n",
       "\\item[ShoppingMall] 'numeric'\n",
       "\\item[Spa] 'numeric'\n",
       "\\item[VRDeck] 'numeric'\n",
       "\\item[Name] 'character'\n",
       "\\end{description*}\n"
      ],
      "text/markdown": [
       "PassengerId\n",
       ":   'character'HomePlanet\n",
       ":   'character'CryoSleep\n",
       ":   'logical'Cabin\n",
       ":   'factor'Destination\n",
       ":   'character'Age\n",
       ":   'numeric'VIP\n",
       ":   'logical'RoomService\n",
       ":   'numeric'FoodCourt\n",
       ":   'numeric'ShoppingMall\n",
       ":   'numeric'Spa\n",
       ":   'numeric'VRDeck\n",
       ":   'numeric'Name\n",
       ":   'character'\n",
       "\n"
      ],
      "text/plain": [
       " PassengerId   HomePlanet    CryoSleep        Cabin  Destination          Age \n",
       " \"character\"  \"character\"    \"logical\"     \"factor\"  \"character\"    \"numeric\" \n",
       "         VIP  RoomService    FoodCourt ShoppingMall          Spa       VRDeck \n",
       "   \"logical\"    \"numeric\"    \"numeric\"    \"numeric\"    \"numeric\"    \"numeric\" \n",
       "        Name \n",
       " \"character\" "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "sapply(test_data, class)\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "id": "8bdd98fd",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-12-19T20:12:09.674633Z",
     "iopub.status.busy": "2022-12-19T20:12:09.673224Z",
     "iopub.status.idle": "2022-12-19T20:12:09.744537Z",
     "shell.execute_reply": "2022-12-19T20:12:09.743078Z"
    },
    "papermill": {
     "duration": 0.080692,
     "end_time": "2022-12-19T20:12:09.747032",
     "exception": false,
     "start_time": "2022-12-19T20:12:09.666340",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 3 × 14</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>PassengerId</th><th scope=col>HomePlanet</th><th scope=col>CryoSleep</th><th scope=col>Cabin</th><th scope=col>Destination</th><th scope=col>Age</th><th scope=col>VIP</th><th scope=col>RoomService</th><th scope=col>FoodCourt</th><th scope=col>ShoppingMall</th><th scope=col>Spa</th><th scope=col>VRDeck</th><th scope=col>Name</th><th scope=col>Transported</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>0001_01</td><td>Europa</td><td>False</td><td>B/0/P</td><td>TRAPPIST-1e</td><td>39</td><td>False</td><td>  0</td><td>   0</td><td> 0</td><td>   0</td><td> 0</td><td>Maham Ofracculy</td><td>False</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>0002_01</td><td>Earth </td><td>False</td><td>F/0/S</td><td>TRAPPIST-1e</td><td>24</td><td>False</td><td>109</td><td>   9</td><td>25</td><td> 549</td><td>44</td><td>Juanna Vines   </td><td>True </td></tr>\n",
       "\t<tr><th scope=row>3</th><td>0003_01</td><td>Europa</td><td>False</td><td>A/0/S</td><td>TRAPPIST-1e</td><td>58</td><td>True </td><td> 43</td><td>3576</td><td> 0</td><td>6715</td><td>49</td><td>Altark Susent  </td><td>False</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 3 × 14\n",
       "\\begin{tabular}{r|llllllllllllll}\n",
       "  & PassengerId & HomePlanet & CryoSleep & Cabin & Destination & Age & VIP & RoomService & FoodCourt & ShoppingMall & Spa & VRDeck & Name & Transported\\\\\n",
       "  & <chr> & <chr> & <chr> & <chr> & <chr> & <dbl> & <chr> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <chr> & <chr>\\\\\n",
       "\\hline\n",
       "\t1 & 0001\\_01 & Europa & False & B/0/P & TRAPPIST-1e & 39 & False &   0 &    0 &  0 &    0 &  0 & Maham Ofracculy & False\\\\\n",
       "\t2 & 0002\\_01 & Earth  & False & F/0/S & TRAPPIST-1e & 24 & False & 109 &    9 & 25 &  549 & 44 & Juanna Vines    & True \\\\\n",
       "\t3 & 0003\\_01 & Europa & False & A/0/S & TRAPPIST-1e & 58 & True  &  43 & 3576 &  0 & 6715 & 49 & Altark Susent   & False\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 3 × 14\n",
       "\n",
       "| <!--/--> | PassengerId &lt;chr&gt; | HomePlanet &lt;chr&gt; | CryoSleep &lt;chr&gt; | Cabin &lt;chr&gt; | Destination &lt;chr&gt; | Age &lt;dbl&gt; | VIP &lt;chr&gt; | RoomService &lt;dbl&gt; | FoodCourt &lt;dbl&gt; | ShoppingMall &lt;dbl&gt; | Spa &lt;dbl&gt; | VRDeck &lt;dbl&gt; | Name &lt;chr&gt; | Transported &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 0001_01 | Europa | False | B/0/P | TRAPPIST-1e | 39 | False |   0 |    0 |  0 |    0 |  0 | Maham Ofracculy | False |\n",
       "| 2 | 0002_01 | Earth  | False | F/0/S | TRAPPIST-1e | 24 | False | 109 |    9 | 25 |  549 | 44 | Juanna Vines    | True  |\n",
       "| 3 | 0003_01 | Europa | False | A/0/S | TRAPPIST-1e | 58 | True  |  43 | 3576 |  0 | 6715 | 49 | Altark Susent   | False |\n",
       "\n"
      ],
      "text/plain": [
       "  PassengerId HomePlanet CryoSleep Cabin Destination Age VIP   RoomService\n",
       "1 0001_01     Europa     False     B/0/P TRAPPIST-1e 39  False   0        \n",
       "2 0002_01     Earth      False     F/0/S TRAPPIST-1e 24  False 109        \n",
       "3 0003_01     Europa     False     A/0/S TRAPPIST-1e 58  True   43        \n",
       "  FoodCourt ShoppingMall Spa  VRDeck Name            Transported\n",
       "1    0       0              0  0     Maham Ofracculy False      \n",
       "2    9      25            549 44     Juanna Vines    True       \n",
       "3 3576       0           6715 49     Altark Susent   False      "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "train_data <- read.csv(\"/kaggle/input/spaceship-titanic/train.csv\")\n",
    "head(train_data,3)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "id": "5b1f9c1f",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-12-19T20:12:09.761889Z",
     "iopub.status.busy": "2022-12-19T20:12:09.760521Z",
     "iopub.status.idle": "2022-12-19T20:12:09.943338Z",
     "shell.execute_reply": "2022-12-19T20:12:09.942134Z"
    },
    "papermill": {
     "duration": 0.191812,
     "end_time": "2022-12-19T20:12:09.945059",
     "exception": false,
     "start_time": "2022-12-19T20:12:09.753247",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Warning message:\n",
      "“Expected 3 pieces. Missing pieces filled with `NA` in 199 rows [16, 94, 104, 223, 228, 252, 261, 273, 281, 296, 315, 318, 345, 416, 437, 457, 463, 488, 666, 680, ...].”\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 2 × 16</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>PassengerId</th><th scope=col>HomePlanet</th><th scope=col>CryoSleep</th><th scope=col>deck</th><th scope=col>num</th><th scope=col>side</th><th scope=col>Destination</th><th scope=col>Age</th><th scope=col>VIP</th><th scope=col>RoomService</th><th scope=col>FoodCourt</th><th scope=col>ShoppingMall</th><th scope=col>Spa</th><th scope=col>VRDeck</th><th scope=col>Name</th><th scope=col>Transported</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>0001_01</td><td>Europa</td><td>False</td><td>B</td><td>0</td><td>P</td><td>TRAPPIST-1e</td><td>39</td><td>False</td><td>  0</td><td>0</td><td> 0</td><td>  0</td><td> 0</td><td>Maham Ofracculy</td><td>False</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>0002_01</td><td>Earth </td><td>False</td><td>F</td><td>0</td><td>S</td><td>TRAPPIST-1e</td><td>24</td><td>False</td><td>109</td><td>9</td><td>25</td><td>549</td><td>44</td><td>Juanna Vines   </td><td>True </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 2 × 16\n",
       "\\begin{tabular}{r|llllllllllllllll}\n",
       "  & PassengerId & HomePlanet & CryoSleep & deck & num & side & Destination & Age & VIP & RoomService & FoodCourt & ShoppingMall & Spa & VRDeck & Name & Transported\\\\\n",
       "  & <chr> & <chr> & <chr> & <chr> & <chr> & <chr> & <chr> & <dbl> & <chr> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <chr> & <chr>\\\\\n",
       "\\hline\n",
       "\t1 & 0001\\_01 & Europa & False & B & 0 & P & TRAPPIST-1e & 39 & False &   0 & 0 &  0 &   0 &  0 & Maham Ofracculy & False\\\\\n",
       "\t2 & 0002\\_01 & Earth  & False & F & 0 & S & TRAPPIST-1e & 24 & False & 109 & 9 & 25 & 549 & 44 & Juanna Vines    & True \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 2 × 16\n",
       "\n",
       "| <!--/--> | PassengerId &lt;chr&gt; | HomePlanet &lt;chr&gt; | CryoSleep &lt;chr&gt; | deck &lt;chr&gt; | num &lt;chr&gt; | side &lt;chr&gt; | Destination &lt;chr&gt; | Age &lt;dbl&gt; | VIP &lt;chr&gt; | RoomService &lt;dbl&gt; | FoodCourt &lt;dbl&gt; | ShoppingMall &lt;dbl&gt; | Spa &lt;dbl&gt; | VRDeck &lt;dbl&gt; | Name &lt;chr&gt; | Transported &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 0001_01 | Europa | False | B | 0 | P | TRAPPIST-1e | 39 | False |   0 | 0 |  0 |   0 |  0 | Maham Ofracculy | False |\n",
       "| 2 | 0002_01 | Earth  | False | F | 0 | S | TRAPPIST-1e | 24 | False | 109 | 9 | 25 | 549 | 44 | Juanna Vines    | True  |\n",
       "\n"
      ],
      "text/plain": [
       "  PassengerId HomePlanet CryoSleep deck num side Destination Age VIP  \n",
       "1 0001_01     Europa     False     B    0   P    TRAPPIST-1e 39  False\n",
       "2 0002_01     Earth      False     F    0   S    TRAPPIST-1e 24  False\n",
       "  RoomService FoodCourt ShoppingMall Spa VRDeck Name            Transported\n",
       "1   0         0          0             0  0     Maham Ofracculy False      \n",
       "2 109         9         25           549 44     Juanna Vines    True       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "train_data_cabin <- train_data %>%\n",
    "    separate(col=Cabin, c(\"deck\", \"num\", \"side\"), sep=\"/\")\n",
    "head(train_data_cabin,2)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "id": "72883b5e",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-12-19T20:12:09.961945Z",
     "iopub.status.busy": "2022-12-19T20:12:09.960528Z",
     "iopub.status.idle": "2022-12-19T20:12:09.992847Z",
     "shell.execute_reply": "2022-12-19T20:12:09.991565Z"
    },
    "papermill": {
     "duration": 0.043461,
     "end_time": "2022-12-19T20:12:09.995244",
     "exception": false,
     "start_time": "2022-12-19T20:12:09.951783",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 3 × 12</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>CryoSleep</th><th scope=col>deck</th><th scope=col>num</th><th scope=col>side</th><th scope=col>Age</th><th scope=col>VIP</th><th scope=col>RoomService</th><th scope=col>FoodCourt</th><th scope=col>ShoppingMall</th><th scope=col>Spa</th><th scope=col>VRDeck</th><th scope=col>Transported</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>0</td><td>3</td><td>1</td><td>1</td><td>39</td><td>0</td><td>  0</td><td>   0</td><td> 0</td><td>   0</td><td> 0</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>0</td><td>7</td><td>1</td><td>2</td><td>24</td><td>0</td><td>109</td><td>   9</td><td>25</td><td> 549</td><td>44</td><td>1</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>0</td><td>2</td><td>1</td><td>2</td><td>58</td><td>1</td><td> 43</td><td>3576</td><td> 0</td><td>6715</td><td>49</td><td>0</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 3 × 12\n",
       "\\begin{tabular}{r|llllllllllll}\n",
       "  & CryoSleep & deck & num & side & Age & VIP & RoomService & FoodCourt & ShoppingMall & Spa & VRDeck & Transported\\\\\n",
       "  & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t1 & 0 & 3 & 1 & 1 & 39 & 0 &   0 &    0 &  0 &    0 &  0 & 0\\\\\n",
       "\t2 & 0 & 7 & 1 & 2 & 24 & 0 & 109 &    9 & 25 &  549 & 44 & 1\\\\\n",
       "\t3 & 0 & 2 & 1 & 2 & 58 & 1 &  43 & 3576 &  0 & 6715 & 49 & 0\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 3 × 12\n",
       "\n",
       "| <!--/--> | CryoSleep &lt;dbl&gt; | deck &lt;dbl&gt; | num &lt;dbl&gt; | side &lt;dbl&gt; | Age &lt;dbl&gt; | VIP &lt;dbl&gt; | RoomService &lt;dbl&gt; | FoodCourt &lt;dbl&gt; | ShoppingMall &lt;dbl&gt; | Spa &lt;dbl&gt; | VRDeck &lt;dbl&gt; | Transported &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 0 | 3 | 1 | 1 | 39 | 0 |   0 |    0 |  0 |    0 |  0 | 0 |\n",
       "| 2 | 0 | 7 | 1 | 2 | 24 | 0 | 109 |    9 | 25 |  549 | 44 | 1 |\n",
       "| 3 | 0 | 2 | 1 | 2 | 58 | 1 |  43 | 3576 |  0 | 6715 | 49 | 0 |\n",
       "\n"
      ],
      "text/plain": [
       "  CryoSleep deck num side Age VIP RoomService FoodCourt ShoppingMall Spa \n",
       "1 0         3    1   1    39  0     0            0       0              0\n",
       "2 0         7    1   2    24  0   109            9      25            549\n",
       "3 0         2    1   2    58  1    43         3576       0           6715\n",
       "  VRDeck Transported\n",
       "1  0     0          \n",
       "2 44     1          \n",
       "3 49     0          "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "train_data_nums <- train_data_cabin %>%\n",
    "    select(3:6,8:14,ncol(train_data_cabin)) %>%\n",
    "    mutate(\n",
    "        CryoSleep = as.numeric(as.logical(CryoSleep)),\n",
    "        deck = as.numeric(as.factor(deck)),\n",
    "        num = as.numeric(as.factor(num)),\n",
    "        side = as.numeric(as.factor(side)),\n",
    "        VIP = as.numeric(as.logical(VIP)),\n",
    "        Transported = as.numeric(as.logical(Transported))\n",
    "    )\n",
    "head(train_data_nums,3)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 8,
   "id": "8410f57b",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-12-19T20:12:10.010766Z",
     "iopub.status.busy": "2022-12-19T20:12:10.009508Z",
     "iopub.status.idle": "2022-12-19T20:12:10.022022Z",
     "shell.execute_reply": "2022-12-19T20:12:10.020515Z"
    },
    "papermill": {
     "duration": 0.022206,
     "end_time": "2022-12-19T20:12:10.023924",
     "exception": false,
     "start_time": "2022-12-19T20:12:10.001718",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "train_data_nums <- train_data_nums %>% drop_na() # CryoSleep, VIP, Age\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 9,
   "id": "872fea46",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-12-19T20:12:10.039320Z",
     "iopub.status.busy": "2022-12-19T20:12:10.037887Z",
     "iopub.status.idle": "2022-12-19T20:12:10.061361Z",
     "shell.execute_reply": "2022-12-19T20:12:10.059914Z"
    },
    "papermill": {
     "duration": 0.033272,
     "end_time": "2022-12-19T20:12:10.063464",
     "exception": false,
     "start_time": "2022-12-19T20:12:10.030192",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "   CryoSleep           deck            num              side      \n",
       " Min.   :0.0000   Min.   :2.000   Min.   :   1.0   Min.   :1.000  \n",
       " 1st Qu.:0.0000   1st Qu.:5.000   1st Qu.: 517.0   1st Qu.:1.000  \n",
       " Median :0.0000   Median :7.000   Median :1002.5   Median :2.000  \n",
       " Mean   :0.3497   Mean   :6.288   Mean   : 951.2   Mean   :1.507  \n",
       " 3rd Qu.:1.0000   3rd Qu.:8.000   3rd Qu.:1338.2   3rd Qu.:2.000  \n",
       " Max.   :1.0000   Max.   :9.000   Max.   :1817.0   Max.   :2.000  \n",
       "      Age             VIP           RoomService       FoodCourt    \n",
       " Min.   : 0.00   Min.   :0.00000   Min.   :   0.0   Min.   :    0  \n",
       " 1st Qu.:19.00   1st Qu.:0.00000   1st Qu.:   0.0   1st Qu.:    0  \n",
       " Median :27.00   Median :0.00000   Median :   0.0   Median :    0  \n",
       " Mean   :28.93   Mean   :0.02414   Mean   : 224.2   Mean   :  472  \n",
       " 3rd Qu.:38.00   3rd Qu.:0.00000   3rd Qu.:  51.0   3rd Qu.:   82  \n",
       " Max.   :79.00   Max.   :1.00000   Max.   :9920.0   Max.   :29813  \n",
       "  ShoppingMall          Spa               VRDeck         Transported    \n",
       " Min.   :    0.0   Min.   :    0.00   Min.   :    0.0   Min.   :0.0000  \n",
       " 1st Qu.:    0.0   1st Qu.:    0.00   1st Qu.:    0.0   1st Qu.:0.0000  \n",
       " Median :    0.0   Median :    0.00   Median :    0.0   Median :1.0000  \n",
       " Mean   :  178.3   Mean   :  314.05   Mean   :  303.5   Mean   :0.5021  \n",
       " 3rd Qu.:   31.0   3rd Qu.:   65.25   3rd Qu.:   52.0   3rd Qu.:1.0000  \n",
       " Max.   :23492.0   Max.   :22408.00   Max.   :20336.0   Max.   :1.0000  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "summary(train_data_nums)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 10,
   "id": "6ecfacd6",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-12-19T20:12:10.079178Z",
     "iopub.status.busy": "2022-12-19T20:12:10.077816Z",
     "iopub.status.idle": "2022-12-19T20:12:10.097126Z",
     "shell.execute_reply": "2022-12-19T20:12:10.095039Z"
    },
    "papermill": {
     "duration": 0.029757,
     "end_time": "2022-12-19T20:12:10.099582",
     "exception": false,
     "start_time": "2022-12-19T20:12:10.069825",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".dl-inline {width: auto; margin:0; padding: 0}\n",
       ".dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}\n",
       ".dl-inline>dt::after {content: \":\\0020\"; padding-right: .5ex}\n",
       ".dl-inline>dt:not(:first-of-type) {padding-left: .5ex}\n",
       "</style><dl class=dl-inline><dt>CryoSleep</dt><dd>0.476896584722649</dd><dt>deck</dt><dd>1.78625142222587</dd><dt>num</dt><dd>503.655332666096</dd><dt>side</dt><dd>0.49998547092238</dd><dt>Age</dt><dd>14.4893799805986</dd><dt>VIP</dt><dd>0.153491184111247</dd><dt>RoomService</dt><dd>642.441869907396</dd><dt>FoodCourt</dt><dd>1649.45413651397</dd><dt>ShoppingMall</dt><dd>627.892092248834</dd><dt>Spa</dt><dd>1147.57115682779</dd><dt>VRDeck</dt><dd>1117.2122973765</dd><dt>Transported</dt><dd>0.500030810611268</dd></dl>\n"
      ],
      "text/latex": [
       "\\begin{description*}\n",
       "\\item[CryoSleep] 0.476896584722649\n",
       "\\item[deck] 1.78625142222587\n",
       "\\item[num] 503.655332666096\n",
       "\\item[side] 0.49998547092238\n",
       "\\item[Age] 14.4893799805986\n",
       "\\item[VIP] 0.153491184111247\n",
       "\\item[RoomService] 642.441869907396\n",
       "\\item[FoodCourt] 1649.45413651397\n",
       "\\item[ShoppingMall] 627.892092248834\n",
       "\\item[Spa] 1147.57115682779\n",
       "\\item[VRDeck] 1117.2122973765\n",
       "\\item[Transported] 0.500030810611268\n",
       "\\end{description*}\n"
      ],
      "text/markdown": [
       "CryoSleep\n",
       ":   0.476896584722649deck\n",
       ":   1.78625142222587num\n",
       ":   503.655332666096side\n",
       ":   0.49998547092238Age\n",
       ":   14.4893799805986VIP\n",
       ":   0.153491184111247RoomService\n",
       ":   642.441869907396FoodCourt\n",
       ":   1649.45413651397ShoppingMall\n",
       ":   627.892092248834Spa\n",
       ":   1147.57115682779VRDeck\n",
       ":   1117.2122973765Transported\n",
       ":   0.500030810611268\n",
       "\n"
      ],
      "text/plain": [
       "   CryoSleep         deck          num         side          Age          VIP \n",
       "   0.4768966    1.7862514  503.6553327    0.4999855   14.4893800    0.1534912 \n",
       " RoomService    FoodCourt ShoppingMall          Spa       VRDeck  Transported \n",
       " 642.4418699 1649.4541365  627.8920922 1147.5711568 1117.2122974    0.5000308 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "sapply(train_data_nums, sd)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 11,
   "id": "df5eb7b7",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-12-19T20:12:10.116252Z",
     "iopub.status.busy": "2022-12-19T20:12:10.114721Z",
     "iopub.status.idle": "2022-12-19T20:12:10.172358Z",
     "shell.execute_reply": "2022-12-19T20:12:10.170322Z"
    },
    "papermill": {
     "duration": 0.068312,
     "end_time": "2022-12-19T20:12:10.174757",
     "exception": false,
     "start_time": "2022-12-19T20:12:10.106445",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "0.819539765845781"
      ],
      "text/latex": [
       "0.819539765845781"
      ],
      "text/markdown": [
       "0.819539765845781"
      ],
      "text/plain": [
       "[1] 0.8195398"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "cryo_sleep <- train_data_nums %>%\n",
    "    filter(train_data_nums$CryoSleep == TRUE) %>%\n",
    "    select(Transported)\n",
    "\n",
    "percent_cryo_transported <- sum(cryo_sleep$Transported, na.rm=TRUE) / nrow(cryo_sleep)\n",
    "percent_cryo_transported"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 12,
   "id": "7634f649",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-12-19T20:12:10.196628Z",
     "iopub.status.busy": "2022-12-19T20:12:10.195246Z",
     "iopub.status.idle": "2022-12-19T20:12:10.225572Z",
     "shell.execute_reply": "2022-12-19T20:12:10.223876Z"
    },
    "papermill": {
     "duration": 0.046301,
     "end_time": "2022-12-19T20:12:10.227806",
     "exception": false,
     "start_time": "2022-12-19T20:12:10.181505",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "           deck\n",
       "Transported    2    3    4    5    6    7    8    9\n",
       "          0  114  182  197  229  478 1310 1014    3\n",
       "          1  106  485  421  169  266 1015 1094    1"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "xtabs(~Transported + deck, data = train_data_nums)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 13,
   "id": "9ca453c4",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-12-19T20:12:10.243424Z",
     "iopub.status.busy": "2022-12-19T20:12:10.242177Z",
     "iopub.status.idle": "2022-12-19T20:12:10.276066Z",
     "shell.execute_reply": "2022-12-19T20:12:10.274150Z"
    },
    "papermill": {
     "duration": 0.044078,
     "end_time": "2022-12-19T20:12:10.278493",
     "exception": false,
     "start_time": "2022-12-19T20:12:10.234415",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "           num\n",
       "Transported  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22\n",
       "          0 10  3  5  3  3  1  1  1  0  0  2  1  1  0  6  0  0  0  0  1  2  0\n",
       "          1  5  9  6  7  2  2  2  1  3  2  1  3  2  2  5  3  2  3  1  1  1  1\n",
       "           num\n",
       "Transported 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44\n",
       "          0  1  1  3  7  1  2  1  1  1  0  1  1  1  0  7  2  1  3  1  1  1  0\n",
       "          1  0  2  1  3  3  0  1  5  0  1  3  1  6  2  8  2  1  3  2  1  0  1\n",
       "           num\n",
       "Transported 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 64 65 66 67\n",
       "          0  3  1  0  5  0  2  0  2  3  6  2  1  1  6  1  1  1  0  1  2  0  2\n",
       "          1  3  2  4  2  1  1  2  2  2  5  3  0  0  6  6  0  2  2  3  1  1  0\n",
       "           num\n",
       "Transported 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89\n",
       "          0  1  3  2  1  1  1  0  1  1  2  1  1  2  1  1  0  2  1  1  0  4  1\n",
       "          1  2  4  1  2  1  2  1  1  0  2  0  1  9  0  2  2  3  1  2  2  1  2\n",
       "           num\n",
       "Transported 90 91 92 93 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109\n",
       "          0  1  2  1  0  0  0  1  1  1   3   1   6   0   0   0   0   1   1   1\n",
       "          1  2  2  0  2  2  3  1  2  4   1   2   9   1   2   3   2   2   2   1\n",
       "           num\n",
       "Transported 110 111 112 113 114 115 116 117 118 119 120 121 123 124 125 126 127\n",
       "          0   0   1   2   4   4   1   0   2   1   3   0   0   2   4   4   1   2\n",
       "          1   2   3   0   9   6   2   1   2   0   1   2   2   4   1   4   1   0\n",
       "           num\n",
       "Transported 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144\n",
       "          0   3   0   2   1   1   3   0   5   1   1   1   0   3   1   1   0   1\n",
       "          1   1   2   1   0   2   3   1   2   2   0   3   4   0   0   3   3   1\n",
       "           num\n",
       "Transported 145 146 147 148 149 150 152 153 154 155 156 157 158 159 160 161 162\n",
       "          0   1   2   0   3   3   0   3   1   1   1   1   6   2   2   0   3   0\n",
       "          1   2   6   1   2   2   1   1   2   2   1   0   1   3   1   2   1   5\n",
       "           num\n",
       "Transported 163 164 165 166 168 169 171 172 173 174 175 176 177 178 179 180 181\n",
       "          0   1   1   1   1   6   2   0   0   2   1   1   0   1   3   2   0   1\n",
       "          1   1   4   1   2   4   2   2   3   2   1   4   2   1   7   2   2   3\n",
       "           num\n",
       "Transported 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198\n",
       "          0   4   0   2   3   0   1   1   4   0   2   2   1   1   1   0   0   1\n",
       "          1   0   1   0   0   3   1   0   7   2   0   1   0   0   0   1   2   1\n",
       "           num\n",
       "Transported 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215\n",
       "          0   2   5   1   2   1   1   2   1   2   3   0   4   2   1   2   1   7\n",
       "          1   0   8   0   0   2   0   2   1   0   0   1   5   1   1   0   0   1\n",
       "           num\n",
       "Transported 216 217 218 219 221 222 223 224 225 226 227 228 229 230 231 232 233\n",
       "          0   2   0   2   1   2   5   2   1   0   1   3   4   2   0   2   1   4\n",
       "          1   1   1   1   1   2   9   1   2   1   1   0   1   1   1   0   1   8\n",
       "           num\n",
       "Transported 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250\n",
       "          0   3   1   2   0   3   2   0   2   2   0   2   0   1   3   3   1   0\n",
       "          1   1   0   0   3   0   3   3   1   0   3   7   1   1   1   0   1   1\n",
       "           num\n",
       "Transported 251 252 253 254 255 256 257 258 259 260 261 262 263 264 265 266 267\n",
       "          0   1   2   1   4   2   2   2   2   1   1   1   3   0   2   6   2   0\n",
       "          1   1   1   2  10   1   1   1   3   1   2   1   2   1   1   5   1   1\n",
       "           num\n",
       "Transported 268 269 270 271 272 273 274 275 276 278 279 280 281 282 283 284 285\n",
       "          0   3   1   3   1   0   1   2   1   6   1   1   3   2   1   1   1   1\n",
       "          1   2   1   0   2   3   1   1   1   9   1   0   2   1   0   0   3   1\n",
       "           num\n",
       "Transported 286 287 288 289 290 291 292 293 294 295 296 297 298 299 300 301 302\n",
       "          0   1   4   2   4   0   0   2   0   3   2   2   2   5   3   3   2   0\n",
       "          1   2   4   0   0   1   2   0   1   0   4   3   0   5   1   1   1   3\n",
       "           num\n",
       "Transported 303 304 305 306 307 308 309 310 311 312 314 315 316 317 318 319 320\n",
       "          0   2   2   2   0   4   1   2   0   2   0   2   0   0   0   1   3   4\n",
       "          1   1   2   1   1   1   1   2   1   0   1   0   1   1   2   0   1   6\n",
       "           num\n",
       "Transported 321 322 323 324 325 326 327 328 329 330 331 332 333 334 335 336 337\n",
       "          0   2   1   2   2   1   1   3   2   2  12   4   1   2   3   0   2   3\n",
       "          1   1   1   2   3   1   1   0   0   0   2   3   2   0   0   1   0   0\n",
       "           num\n",
       "Transported 338 339 340 341 342 343 344 345 346 347 348 349 350 351 352 353 354\n",
       "          0   1   2   3   1   2   2   1   3   2   2   2   1   3   1   2   2   3\n",
       "          1   2   0   1   1   4   1   0   0   5   1   2   3   1   2   5   7   2\n",
       "           num\n",
       "Transported 355 356 357 358 359 360 361 362 363 364 365 366 367 368 369 371 372\n",
       "          0   2   3   1   0   1   0   1   3   2   2   2   1   1   2   1   1   1\n",
       "          1   0   2   1   1   1   1   1   0   0  12   3   1   2   0   3   2   0\n",
       "           num\n",
       "Transported 373 374 375 376 377 379 380 381 382 383 384 385 386 387 388 389 390\n",
       "          0   1   3   3   0   2   2   2   0   2   1   1   0   5   3   0   0   2\n",
       "          1   1   3   6   2   0   1   1   1   1   0   1   1   4   0   3   2   0\n",
       "           num\n",
       "Transported 391 392 393 394 395 396 397 398 399 400 401 402 403 404 405 406 407\n",
       "          0   2   2   2   1   3   1   6   1   2   1   1   3   1   1   0   4   2\n",
       "          1   0   0   2   1   1   1   4   1   1   2   2   1   1   0   1   3   0\n",
       "           num\n",
       "Transported 408 409 410 411 412 413 414 415 416 417 418 419 420 421 422 423 424\n",
       "          0   7   1   1   2   1   2   1   1   2   1   2   4   1   2   3   1   2\n",
       "          1   9   1   1   1   0   0   1   0   2   2   1   1   0   1   1   0   0\n",
       "           num\n",
       "Transported 425 426 427 428 429 430 432 433 434 435 436 437 438 439 440 441 442\n",
       "          0   1   1   1   0   0   4   1   2   1   0   3   2   2   1   3   4   3\n",
       "          1   1   0   4   1   1   2   2   2   1   2   0   1   1   2   0  11   8\n",
       "           num\n",
       "Transported 443 444 445 446 447 448 450 451 452 453 454 455 456 457 458 459 460\n",
       "          0   1   2   1   0   1   1   1   2   6   2   6   1   2   1   1   4   3\n",
       "          1   2   2   0   2   1   0   0   1   3   2   4   2   0   1   0   2   0\n",
       "           num\n",
       "Transported 461 462 463 464 465 466 468 470 471 472 473 474 475 476 477 478 479\n",
       "          0   2   0   4   2   2   0   0   1   1   2   1   7   1   2   1   5   2\n",
       "          1   3   2   7   0   1   3   1   0   1   0   2   3   2   1   3   1   1\n",
       "           num\n",
       "Transported 480 481 482 483 484 485 486 487 488 489 490 491 492 493 494 495 496\n",
       "          0   1   0   1   1   3   4   0   1   3   2   2   1   1   2   1   3   2\n",
       "          1   2   2   0   1   0  10   2   1   0   0   0   1   0   1   1   7   2\n",
       "           num\n",
       "Transported 497 498 499 500 501 502 503 504 505 506 507 508 509 510 511 512 513\n",
       "          0   0   3   3   1   4   1   3   3   0   6   3   2   2   1   2   2   3\n",
       "          1   1   0   2   1   0   0   1   1   1   4   3   2   0   0   0   2   2\n",
       "           num\n",
       "Transported 514 515 517 518 519 520 521 522 523 524 525 526 527 528 529 530 531\n",
       "          0   2   2   2   1   2   1   1   1   2   5   0   1   1   4   2   1   0\n",
       "          1   2   1   5   1   0   0   1   0   0   8   3   0   1   3   0   0   2\n",
       "           num\n",
       "Transported 532 533 534 535 536 537 538 539 540 541 542 543 544 545 546 547 548\n",
       "          0   1   1   2   2   1   2   1   5   3   1   1   2   1   1   1   1   1\n",
       "          1   0   2   1   0   1   1   1   6   1   1   0   1   4   1   2   1   3\n",
       "           num\n",
       "Transported 549 550 551 552 553 554 555 556 557 558 559 560 561 562 564 565 566\n",
       "          0   2   3   4   2   0   2   0   1   0   1   1   2   1   4   0   0   1\n",
       "          1   0   6   9   1   2   2   1   1   2   1   1   1   0   7   1   1   1\n",
       "           num\n",
       "Transported 567 568 569 571 572 573 574 575 576 577 578 579 580 581 582 583 584\n",
       "          0   1   0   2   1   4   0   1   1   2   1   1   0   2   1   6   0   1\n",
       "          1   0   1   0   0   8   2   0   1   0   0   0   1   0   0   1   2   0\n",
       "           num\n",
       "Transported 585 586 587 588 589 590 592 593 594 595 596 597 598 599 600 602 603\n",
       "          0   2   0   1   0   2   1   3   1   2   0   0   1   1   1   0   3   1\n",
       "          1   0   2   1   1   0   0   6   0   1   1   1   2   1   0   1   4   2\n",
       "           num\n",
       "Transported 604 605 606 607 608 609 610 611 612 613 614 615 616 617 618 619 620\n",
       "          0   0   2   2   1   2   1   0   1   4   2   2   0   2   1   0   2   2\n",
       "          1   1   0   2   0   0   1   1   0   9   0   1   1   0   0   1   0   4\n",
       "           num\n",
       "Transported 621 622 623 624 625 626 627 628 629 630 632 633 634 635 636 637 638\n",
       "          0   1   1   1   1   2   1   1   1   1   7   1   0   1   0   0   0   4\n",
       "          1   1   0   3   1   0   0   0   0   1   4   0   2   0   2   2   1   4\n",
       "           num\n",
       "Transported 639 640 641 642 643 644 645 646 648 649 650 651 652 653 654 655 656\n",
       "          0   1   1   0   1   1   1   1   1   3   3   1   2   1   1   1   1   2\n",
       "          1   1   0   1   0   0   0   0   1  11   3   0   0   1   0   1   1   0\n",
       "           num\n",
       "Transported 657 658 659 660 661 663 664 665 666 667 668 669 670 671 672 673 674\n",
       "          0   0   1   2   3   1   0   2   0   1   1   1   0   0   3   2   2   1\n",
       "          1   1   0   0   5   0   1   0   1   1   0   0   1   1   5   0   0   0\n",
       "           num\n",
       "Transported 675 676 677 678 679 680 681 682 684 685 686 687 688 689 690 691 692\n",
       "          0   2   1   1   1   1   0   4   3   2   1   0   0   0   1   1   3   0\n",
       "          1   0   1   0   0   0   2   6   0   0   1   1   1   1   0   0   2   1\n",
       "           num\n",
       "Transported 693 694 695 696 697 698 699 700 701 702 703 704 705 706 707 708 709\n",
       "          0   2   1   1   1   1   1   0   3   1   1   1   0   2   1   1   1   5\n",
       "          1   0   1   0   1   0   0   1   4   0   0   6   1   0   0   0   1   9\n",
       "           num\n",
       "Transported 710 711 712 713 715 716 717 718 719 721 722 723 724 725 727 728 729\n",
       "          0   0   2   1   2   1   1   2   1   4   0   1   1   1   2   3   1   1\n",
       "          1   1   0   0   0   0   2   1   0   3   1   0   0   0   0   0   0   0\n",
       "           num\n",
       "Transported 730 732 733 734 735 736 737 738 739 740 741 742 743 744 745 746 747\n",
       "          0   4   1   0   2   1   1   1   2   1   1   3   1   1   1   1   2   1\n",
       "          1   4   0   1   1   0   0   0   0   0   0   4   1   0   0   0   1   1\n",
       "           num\n",
       "Transported 748 750 751 752 753 754 755 756 757 758 759 760 761 762 763 764 765\n",
       "          0   0   6   4   0   0   0   0   3   2   1   1   0   1   7   1   2   0\n",
       "          1   2   1   5   1   1   1   1   2   0   0   0   1   0   3   1   2   1\n",
       "           num\n",
       "Transported 766 767 768 769 771 772 773 774 775 778 779 780 781 782 783 784 785\n",
       "          0   1   1   2   1   0   2   0   0   1   1   0   1   0   5   0   1   1\n",
       "          1   1   0   1   1   1   3   1   2   1   1   1   0   3   3   1   0   2\n",
       "           num\n",
       "Transported 786 787 788 791 792 793 794 795 796 797 798 799 801 802 804 805 806\n",
       "          0   1   0   2   4   1   2   1   1   0   2   2   0   0   5   1   1   2\n",
       "          1   0   1   0   3   1   0   0   1   1   0   0   4   1   9   0   0   0\n",
       "           num\n",
       "Transported 807 808 809 810 811 812 813 814 815 816 817 819 820 821 822 823 824\n",
       "          0   1   1   2   2   9   1   2   1   2   1   1   2   2   1   1   0   2\n",
       "          1   0   0   0   3  11   0   0   2   0   1   1   4   0   0   1   3   0\n",
       "           num\n",
       "Transported 825 826 827 828 829 830 831 832 833 834 835 836 837 838 839 840 842\n",
       "          0   1   0   1   0   1   9   0   0   1   0   1   1   2   2   1   5   1\n",
       "          1   1   1   0   1   2   4   2   1   0   2   0   0   2   0   1   4   1\n",
       "           num\n",
       "Transported 843 844 845 846 847 848 849 851 852 853 854 855 857 858 859 860 861\n",
       "          0   1   1   2   1   6   4   0   1   3   0   3   3   1   1   0   1   1\n",
       "          1   0   0   0   0  10   3   1   0   0   1   3   8   0   0   1   0   0\n",
       "           num\n",
       "Transported 862 863 864 865 866 867 868 869 870 871 872 873 874 875 876 877 878\n",
       "          0   1   5   0   1   0   1   0   0   1   0   0   7   0   0   1   0   1\n",
       "          1   0   4   1   0   1   0   1   3   0   1   1   8   1   2   0   1   0\n",
       "           num\n",
       "Transported 879 880 881 883 884 886 887 888 889 890 891 892 893 894 895 896 897\n",
       "          0   4   1   5   1   1   0   1   0   7   1   1   0   1   1  10   0   0\n",
       "          1   0   0   3   0   0   1   0   1   5   0   0   1   0   1   7   1   1\n",
       "           num\n",
       "Transported 899 900 902 903 904 905 906 907 908 909 911 913 915 916 917 918 920\n",
       "          0   1   1   4   1   1   1   1   0   1   1   3   0   0   8   0   1   1\n",
       "          1   0   0   9   0   0   0   0   1   0   0   3   1   2   3   1   0   0\n",
       "           num\n",
       "Transported 921 922 923 924 925 926 927 928 929 930 931 932 933 934 935 936 937\n",
       "          0   8   7   3   6   3   4   6   6   2   3   5   5   7   3   6   3   4\n",
       "          1  11   5   4   3   6   7   4   3   1   6   6   3   4   7   8   5   6\n",
       "           num\n",
       "Transported 938 939 940 941 942 943 944 945 946 947 948 949 950 951 952 953 954\n",
       "          0   3   4   4   3   4   4   6   4   6   3   4   4   3   4   4   5   6\n",
       "          1   2   3   7   2   3   5   8   4   3   2   8   5   4   8   7   6   4\n",
       "           num\n",
       "Transported 955 956 957 958 959 960 961 962 963 964 965 966 967 968 969 970 971\n",
       "          0   7   3   3   4   3   1   4   8   5   5   4   9   4   3   3   7   3\n",
       "          1   3   7   3   8   4   5   9   3  10   1   6   6  10   3   5   3   3\n",
       "           num\n",
       "Transported 972 973 974 975 976 977 978 979 980 981 982 983 984 985 986 987 988\n",
       "          0   4   1   4   8   4   5   4   4   3   4   4   2   7   4   2   0   6\n",
       "          1   6   6   5   5   4   6   4   4   4   3   3   7   3   9   4   9   8\n",
       "           num\n",
       "Transported 989 990 991 992 993 994 995 996 997 998 999 1000 1001 1002 1003\n",
       "          0   2   4   3   5   5   5   2   4   2   4   1    7    4    3    3\n",
       "          1   7   4   7   6   3   7   5   3   9   4   8    5    3    7    3\n",
       "           num\n",
       "Transported 1004 1005 1006 1007 1008 1009 1010 1011 1012 1013 1014 1015 1016\n",
       "          0    4    4    4    5    6    8    7    6    2    5    4    4    3\n",
       "          1    6    8    5    6    4    9    6    6    6    5    2    1    2\n",
       "           num\n",
       "Transported 1017 1018 1019 1020 1021 1022 1023 1024 1025 1026 1027 1028 1029\n",
       "          0    5    4    4    6    4    4    3    3    6    1    5    2    6\n",
       "          1    4    6    3    8    4    2    7    2    8    6    4    4    4\n",
       "           num\n",
       "Transported 1030 1031 1032 1033 1034 1035 1036 1037 1038 1039 1040 1041 1042\n",
       "          0    6    3    8    4    5    4    1    1    1    2    2    3    3\n",
       "          1    3    5    4    1    6    3    4    3    4    2    8    5    5\n",
       "           num\n",
       "Transported 1043 1044 1045 1046 1047 1048 1049 1050 1051 1052 1053 1054 1055\n",
       "          0    4    3    1    2    2    4    3    5    4    5    3    7    5\n",
       "          1   10    4    5    3    4    2    2    2    6    2    4    2    3\n",
       "           num\n",
       "Transported 1056 1057 1058 1059 1060 1061 1062 1063 1064 1065 1066 1067 1068\n",
       "          0    3    1    1    3    4    3    4    7    1    3    6    3    6\n",
       "          1    4    3    4    1    0    4    1    3    2    7    3    1    1\n",
       "           num\n",
       "Transported 1069 1070 1071 1072 1073 1074 1075 1076 1077 1078 1079 1080 1081\n",
       "          0    1    2    4    3    3    3    4    1    4    5    4    1    0\n",
       "          1    4    6    1    3    4    0    0    6    2    6    5    1    3\n",
       "           num\n",
       "Transported 1082 1083 1084 1085 1086 1087 1088 1089 1090 1091 1092 1093 1094\n",
       "          0    3    5    3    2    4    5    2    3    3    3    3    4    1\n",
       "          1    4    1    5    3    2    4    1    3    2    3    1    0    0\n",
       "           num\n",
       "Transported 1095 1096 1097 1098 1099 1100 1101 1102 1103 1104 1105 1106 1107\n",
       "          0    2    2    2    3    9    2    2    6    0    2    2    5    1\n",
       "          1    0    1    2    2    6    0    1    2    1    1    3    0    3\n",
       "           num\n",
       "Transported 1108 1109 1110 1111 1112 1113 1114 1115 1116 1117 1118 1119 1120\n",
       "          0    2    2    2    1    1    1    2    1    4    2    1    2    0\n",
       "          1    2    1    5    1    2    2    0    0    0    1    3    2    1\n",
       "           num\n",
       "Transported 1121 1122 1123 1124 1125 1126 1127 1128 1129 1130 1131 1132 1133\n",
       "          0    6    3    2    4    2    2    2    4    1    1    2    5    2\n",
       "          1    6    1    3    1    1    1    1    1    6    0    1    5    1\n",
       "           num\n",
       "Transported 1134 1135 1136 1137 1138 1139 1140 1141 1142 1143 1144 1145 1146\n",
       "          0    3    1    4    2    3    2    3    2    0    3    4    5    1\n",
       "          1    1    0    4    0    2    2    1    2    1    6    2    0    1\n",
       "           num\n",
       "Transported 1147 1148 1149 1150 1151 1152 1153 1154 1155 1156 1157 1158 1159\n",
       "          0    2    2    3    3    2    3    1    4    3    1    3    1    2\n",
       "          1    2    3    0    1    0    1    1    2    2    1    0    2    1\n",
       "           num\n",
       "Transported 1160 1162 1163 1164 1165 1166 1167 1168 1169 1170 1171 1172 1173\n",
       "          0    4    1    6    1    3    3    4    2    4    3    2    2    0\n",
       "          1    0    0    1    2    0    7    0    2    1    2    1    1    1\n",
       "           num\n",
       "Transported 1174 1175 1176 1177 1178 1179 1180 1181 1182 1183 1184 1185 1186\n",
       "          0    2    1    1    6    7    4    2    0    3    2    3    3    2\n",
       "          1    1    1    3    7    1    2    1    7    2    2    2    1    1\n",
       "           num\n",
       "Transported 1187 1188 1189 1190 1191 1192 1193 1194 1195 1196 1197 1198 1199\n",
       "          0    4    6    3    4    4    3    1    2    2    4    6    5    9\n",
       "          1    1    6    0    1    1    1    1    2    0    1    2    2    5\n",
       "           num\n",
       "Transported 1200 1201 1202 1203 1204 1205 1206 1207 1208 1209 1210 1211 1212\n",
       "          0    3    0    3    2    2    4    1    3    1    5    5    2    1\n",
       "          1    1    2    1    0    0    2    2    1    4    2    2    6    1\n",
       "           num\n",
       "Transported 1213 1214 1215 1216 1217 1218 1219 1220 1221 1222 1223 1224 1225\n",
       "          0    1    1    2    2    2    4    1    3    5    3    3    2    3\n",
       "          1    3    1    2    3    1    1    2    1    7    1    2    0    1\n",
       "           num\n",
       "Transported 1226 1227 1228 1229 1230 1231 1232 1233 1234 1235 1236 1237 1238\n",
       "          0    2    3    4    2    4    4    5    3    2    1    2    4    2\n",
       "          1    2    2    2    2    1    3    7    0    1    1    1    1    3\n",
       "           num\n",
       "Transported 1239 1240 1241 1242 1243 1244 1245 1246 1247 1248 1249 1250 1251\n",
       "          0    3    2    6    1    6    1    2    2    2    2    1    3    3\n",
       "          1    0    2    0    1    5    1    2    1    2    0    3    0    1\n",
       "           num\n",
       "Transported 1252 1253 1254 1255 1256 1257 1258 1259 1260 1261 1262 1263 1264\n",
       "          0    3    1    3    2    1    2    2    0    1    4    2    3    3\n",
       "          1    0    2    7    1    1    5    0    1    0    0    0    0    4\n",
       "           num\n",
       "Transported 1265 1266 1267 1268 1269 1270 1271 1272 1273 1274 1275 1276 1277\n",
       "          0    5    2    3    1    2    0    2    5    3    0    2    0    9\n",
       "          1    7   11    3    1    1    3    1    1    1    4    3    3    1\n",
       "           num\n",
       "Transported 1278 1279 1280 1281 1282 1283 1284 1285 1286 1287 1288 1289 1290\n",
       "          0    5    2    2    4    2    2    1    1    0    1    3    2    5\n",
       "          1    0    2    0    2    1    1    2    4    2    1    4    0    0\n",
       "           num\n",
       "Transported 1291 1292 1293 1294 1295 1296 1297 1298 1299 1300 1301 1302 1303\n",
       "          0    4    2    2    1    1    1    3    2   10    3    3    5    2\n",
       "          1    2    3    1    7    1    2    0    1    7    1    2    1    3\n",
       "           num\n",
       "Transported 1304 1305 1306 1307 1308 1309 1310 1311 1312 1313 1314 1315 1316\n",
       "          0    1    2    2    2    1    3    8    4    3    3    2    1    1\n",
       "          1    3    2    2    2    1    1    5    0    4    1    2    2    2\n",
       "           num\n",
       "Transported 1317 1318 1319 1320 1321 1322 1323 1324 1325 1326 1327 1328 1329\n",
       "          0    2    2    3    1    8    3    0    0    3    3    1    3    2\n",
       "          1    4    4    1    1    6    1    3    2    3    1    2    2    1\n",
       "           num\n",
       "Transported 1330 1331 1332 1333 1334 1335 1336 1337 1338 1339 1340 1341 1342\n",
       "          0    4    4    6    0    3    1    2    3    2    2    2    3    2\n",
       "          1    1    0   14    1    0    3    2    2    2    0    1    2    0\n",
       "           num\n",
       "Transported 1343 1344 1345 1346 1347 1348 1349 1350 1351 1352 1353 1354 1355\n",
       "          0    9    4    1    2    1    3    6    2    2    5    1    6    3\n",
       "          1    4    1    1    1    2    4    1    1    3    0    2    4    2\n",
       "           num\n",
       "Transported 1356 1357 1358 1359 1360 1361 1362 1363 1364 1365 1366 1367 1368\n",
       "          0    0    3    1    3    2    2    1    1    3    4    0    3    4\n",
       "          1    2    2    1    1    5    4    1    3    0   10    1    0    1\n",
       "           num\n",
       "Transported 1369 1370 1371 1372 1373 1374 1375 1376 1377 1378 1379 1380 1381\n",
       "          0    2    2    1    1    2    3    3    6   10    1    6    4    3\n",
       "          1    3    1    3    1    0    1    0    3    4    3    0    1    3\n",
       "           num\n",
       "Transported 1382 1383 1384 1385 1386 1387 1388 1389 1390 1391 1392 1393 1394\n",
       "          0    1    0    1    0    1    0    5    1    0    1    1    1    2\n",
       "          1    2    1    4    3    1    4    7    0    1    1    1    1    1\n",
       "           num\n",
       "Transported 1395 1396 1397 1398 1399 1400 1401 1402 1403 1404 1406 1407 1409\n",
       "          0    1    2    1    3    6    1    1    2    0    1    3    3    6\n",
       "          1    1    2    1    2    7    1    0    1    2    1    0    0    7\n",
       "           num\n",
       "Transported 1410 1411 1412 1413 1414 1415 1416 1417 1418 1419 1420 1421 1422\n",
       "          0    3    1    0    0    1    1    4    2    1    0    5    0    0\n",
       "          1    6    2    2    3    1    3    2    0    1    1    4    2    3\n",
       "           num\n",
       "Transported 1423 1424 1425 1426 1427 1428 1429 1430 1431 1432 1433 1434 1435\n",
       "          0    1    2    2    2    2    2    0    1    5    1    1    0    0\n",
       "          1    4    0    0    0    1    0    4    2   12    1    0    2    1\n",
       "           num\n",
       "Transported 1436 1437 1438 1439 1440 1441 1442 1443 1444 1445 1446 1447 1448\n",
       "          0    2    5    2    3    1    2    6    0    4    2    0    1    1\n",
       "          1    1    1    1    3    3    4    5    2    1    1    1    2    0\n",
       "           num\n",
       "Transported 1449 1450 1451 1452 1453 1454 1455 1456 1457 1458 1459 1460 1461\n",
       "          0    0    2    1    2    6    1    1    1    2    1    2    2    0\n",
       "          1    1    0    2    1    4    1    0    1    0    1    1    1    1\n",
       "           num\n",
       "Transported 1462 1463 1464 1466 1468 1469 1470 1471 1472 1473 1474 1475 1476\n",
       "          0    1    2    4    1    0    1    0    3    2    1    3    3    2\n",
       "          1    1    0   10    0    2    0    2    1    1    3    0    3    0\n",
       "           num\n",
       "Transported 1477 1478 1479 1480 1481 1482 1483 1484 1485 1486 1487 1488 1489\n",
       "          0    2    2    1    2    0    2    1    5    1    3    2    1    2\n",
       "          1    2    0    1    0    1    1    5    2    0    4    5    3    0\n",
       "           num\n",
       "Transported 1490 1491 1492 1493 1494 1495 1496 1497 1498 1499 1500 1501 1502\n",
       "          0    1    1    0    1    1    1    1    1    1    0    2    1    0\n",
       "          1    1    1    2    0    1    3    1    3    6    2    3    1    1\n",
       "           num\n",
       "Transported 1503 1504 1505 1506 1507 1508 1509 1510 1511 1512 1513 1514 1515\n",
       "          0    1    1    0    3    2    0    6    2    0    3    0    1    2\n",
       "          1    1    0    3    0    1    3    8    1    1    0    2    0    3\n",
       "           num\n",
       "Transported 1516 1517 1518 1519 1520 1521 1522 1523 1524 1525 1526 1527 1528\n",
       "          0    0    1    2    2    1    0    1    3    1    5    1    1    1\n",
       "          1    1    1    0    2    5    2    1    3    1    3    3    2    2\n",
       "           num\n",
       "Transported 1529 1530 1531 1532 1533 1534 1535 1537 1538 1539 1540 1541 1542\n",
       "          0    3    2    4    3    0    1    2    1    3    1    1    1    5\n",
       "          1    1    2    4    2    1    2    4    2    0    1    2    1    8\n",
       "           num\n",
       "Transported 1543 1544 1545 1546 1547 1548 1549 1550 1551 1552 1553 1554 1555\n",
       "          0    1    1    2    1    2    3    2    5    1    0    6    0    1\n",
       "          1    1    2    1    2    1    2    0    1    2    1    3    3    2\n",
       "           num\n",
       "Transported 1556 1557 1558 1559 1560 1561 1562 1563 1564 1565 1566 1567 1568\n",
       "          0    2    2    1    2    1    1    1    2    6    1    1    0    1\n",
       "          1    2    0    1    7    1    0    2    0    3    1    1    1    1\n",
       "           num\n",
       "Transported 1569 1570 1571 1572 1573 1574 1575 1576 1577 1578 1579 1580 1582\n",
       "          0    0    1    2    1    3    0    5    1    0    1    2    1    1\n",
       "          1    1    0    1    1    2    1    7    1    2    1    1    0    3\n",
       "           num\n",
       "Transported 1583 1584 1585 1586 1587 1588 1589 1590 1591 1592 1593 1594 1595\n",
       "          0    2    0    1    8    1    1    0    2    2    1    0    2    0\n",
       "          1    1    2    1    2    2    1    2    0    2    2    1    1    1\n",
       "           num\n",
       "Transported 1596 1597 1598 1599 1600 1601 1602 1603 1604 1605 1606 1607 1608\n",
       "          0    1    6    8    2    1    0    1    2    3    0    1    1    1\n",
       "          1    4    4    2    0    1    1    2    1    2    1    1    2    1\n",
       "           num\n",
       "Transported 1609 1610 1611 1612 1613 1614 1615 1616 1617 1618 1619 1620 1621\n",
       "          0    5    2    1    2    1    5    0    0    3    2    0   10    2\n",
       "          1    4    3    3    1    4    0    1    3    0    1    1   12    0\n",
       "           num\n",
       "Transported 1622 1623 1624 1625 1626 1627 1628 1629 1630 1631 1632 1633 1634\n",
       "          0    2    1    1    1    1    1    0    1    1    8    0    1    1\n",
       "          1    2    1    2    0    1    2    2    0    3    7    2    1    0\n",
       "           num\n",
       "Transported 1635 1636 1637 1638 1639 1640 1641 1642 1643 1644 1645 1646 1647\n",
       "          0    2    1    0    1    0    3    3    3    0    3    1    1    1\n",
       "          1    1    1    2    3    2    2    2    3    2    2    1    0    0\n",
       "           num\n",
       "Transported 1648 1649 1650 1651 1652 1653 1654 1655 1656 1657 1658 1659 1660\n",
       "          0    1    1    2    1    1    3    0    1    2    1    1    1    3\n",
       "          1    2    2    1    2    2    7    2    1    1    1    1    1    6\n",
       "           num\n",
       "Transported 1661 1662 1663 1664 1665 1666 1667 1668 1669 1670 1671 1672 1673\n",
       "          0    3    1    1    8    1    0    0    0    0    1    1    0    4\n",
       "          1    3    1    5    9    2    1    7    1    2    1    0    3    0\n",
       "           num\n",
       "Transported 1674 1675 1676 1677 1678 1679 1680 1681 1682 1683 1684 1685 1686\n",
       "          0    1    4    1    1    3    3    0    2    1    0    0    0    3\n",
       "          1    2    6    1    1    4    1    1    1    0    2    1    1    4\n",
       "           num\n",
       "Transported 1687 1688 1689 1690 1691 1692 1693 1694 1695 1696 1697 1698 1699\n",
       "          0    3    2    2    0    1    2    1    0    1    1    6    0    1\n",
       "          1    2    2    3    2    2    1    1    2    2    2    5    3    1\n",
       "           num\n",
       "Transported 1700 1701 1702 1703 1704 1705 1706 1707 1708 1709 1710 1711 1712\n",
       "          0    0    3    1    1    1    2    1    1    4    4    1    0    2\n",
       "          1    1    2    3    1    1    1    1    0    6    5    4    1    1\n",
       "           num\n",
       "Transported 1713 1714 1715 1716 1717 1718 1719 1720 1721 1722 1723 1724 1725\n",
       "          0    2    1    2    1    1    0    7    2    0    1    1    0    0\n",
       "          1    4    4    1    3    2    1    8    0    2    1    2    1    2\n",
       "           num\n",
       "Transported 1726 1727 1728 1729 1730 1731 1732 1733 1734 1735 1736 1737 1738\n",
       "          0    1    0    2    0    6    2    2    1    0    1    0    3    1\n",
       "          1    3    3    1    2    6    4    1    4    1    2    3    1    1\n",
       "           num\n",
       "Transported 1739 1740 1741 1742 1743 1745 1746 1747 1748 1749 1750 1751 1752\n",
       "          0    2    2    1    0    0    2    2    1    1    0    3    0    6\n",
       "          1    0    1    6    2    1    2    1    4    3    6    2    2    7\n",
       "           num\n",
       "Transported 1753 1754 1755 1756 1757 1758 1759 1760 1761 1762 1763 1764 1765\n",
       "          0    1    1    1    1    0    2    1    0    1    0    6    1    2\n",
       "          1    1    1    0    6    1    2    1    1    2    3    9    1    0\n",
       "           num\n",
       "Transported 1766 1767 1768 1769 1770 1771 1772 1773 1774 1775 1776 1778 1779\n",
       "          0    0    0    4    1    0    2    1    1    7    1    0    1    1\n",
       "          1    3    3    3    2    1    1    4    2    8    1    5    2    2\n",
       "           num\n",
       "Transported 1780 1781 1782 1783 1784 1785 1786 1787 1788 1789 1790 1791 1793\n",
       "          0    2    1    1    0    1    8    1    1    1    2    6    0    1\n",
       "          1    2    0    1    2    2   11    4    0    6    0    1    2    1\n",
       "           num\n",
       "Transported 1794 1795 1796 1797 1798 1799 1800 1801 1802 1803 1804 1805 1806\n",
       "          0    1    1    7    1    0    1    2    2    0    0    1    1    0\n",
       "          1    0    1    3    3    9    3    0    2    1    3    1    2    1\n",
       "           num\n",
       "Transported 1807 1808 1809 1810 1811 1812 1813 1814 1815 1816 1817\n",
       "          0    3    2    1    1    1    2    1    0    2    2    0\n",
       "          1   10    1    4    1    1    5    1    1    0    1    4"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "xtabs(~Transported + num, data = train_data_nums)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 14,
   "id": "12a63729",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-12-19T20:12:10.295595Z",
     "iopub.status.busy": "2022-12-19T20:12:10.294384Z",
     "iopub.status.idle": "2022-12-19T20:12:10.319371Z",
     "shell.execute_reply": "2022-12-19T20:12:10.317587Z"
    },
    "papermill": {
     "duration": 0.035992,
     "end_time": "2022-12-19T20:12:10.321672",
     "exception": false,
     "start_time": "2022-12-19T20:12:10.285680",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "           side\n",
       "Transported    1    2\n",
       "          0 1927 1600\n",
       "          1 1565 1992"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "xtabs(~Transported + side, data = train_data_nums)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 15,
   "id": "8e08cc3f",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-12-19T20:12:10.339947Z",
     "iopub.status.busy": "2022-12-19T20:12:10.338732Z",
     "iopub.status.idle": "2022-12-19T20:12:10.424806Z",
     "shell.execute_reply": "2022-12-19T20:12:10.422944Z"
    },
    "papermill": {
     "duration": 0.097813,
     "end_time": "2022-12-19T20:12:10.427173",
     "exception": false,
     "start_time": "2022-12-19T20:12:10.329360",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "\n",
       "Call:\n",
       "glm(formula = Transported ~ CryoSleep + deck + side, family = \"binomial\", \n",
       "    data = train_data_nums)\n",
       "\n",
       "Deviance Residuals: \n",
       "    Min       1Q   Median       3Q      Max  \n",
       "-2.1329  -0.8433   0.3681   0.8148   1.8091  \n",
       "\n",
       "Coefficients:\n",
       "            Estimate Std. Error z value Pr(>|z|)    \n",
       "(Intercept) -0.86983    0.15450  -5.630  1.8e-08 ***\n",
       "CryoSleep1   2.35215    0.06779  34.696  < 2e-16 ***\n",
       "deck3        0.66688    0.18003   3.704 0.000212 ***\n",
       "deck4        0.68373    0.17857   3.829 0.000129 ***\n",
       "deck5       -0.12360    0.18815  -0.657 0.511218    \n",
       "deck6       -0.47277    0.17329  -2.728 0.006367 ** \n",
       "deck7       -0.05506    0.15764  -0.349 0.726875    \n",
       "deck8       -0.55018    0.16129  -3.411 0.000647 ***\n",
       "deck9       -0.22878    1.16499  -0.196 0.844311    \n",
       "side2        0.49159    0.05522   8.903  < 2e-16 ***\n",
       "---\n",
       "Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1\n",
       "\n",
       "(Dispersion parameter for binomial family taken to be 1)\n",
       "\n",
       "    Null deviance: 9820.4  on 7083  degrees of freedom\n",
       "Residual deviance: 7880.8  on 7074  degrees of freedom\n",
       "AIC: 7900.8\n",
       "\n",
       "Number of Fisher Scoring iterations: 4\n"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "train_data_nums$deck <- factor(train_data_nums$deck)\n",
    "train_data_nums$side <- factor(train_data_nums$side)\n",
    "train_data_nums$VIP <- factor(train_data_nums$VIP)\n",
    "train_data_nums$CryoSleep <- factor(train_data_nums$CryoSleep)\n",
    "\n",
    "\n",
    "mylogit <- glm(Transported ~ CryoSleep + deck + side, data = train_data_nums, family = \"binomial\")\n",
    "summary(mylogit)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 16,
   "id": "4621dc8b",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-12-19T20:12:10.448871Z",
     "iopub.status.busy": "2022-12-19T20:12:10.447323Z",
     "iopub.status.idle": "2022-12-19T20:12:11.808020Z",
     "shell.execute_reply": "2022-12-19T20:12:11.806004Z"
    },
    "papermill": {
     "duration": 1.374043,
     "end_time": "2022-12-19T20:12:11.810459",
     "exception": false,
     "start_time": "2022-12-19T20:12:10.436416",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Waiting for profiling to be done...\n",
      "\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A matrix: 10 × 2 of type dbl</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>2.5 %</th><th scope=col>97.5 %</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>(Intercept)</th><td>-1.1751032</td><td>-0.5688343</td></tr>\n",
       "\t<tr><th scope=row>CryoSleep1</th><td> 2.2204081</td><td> 2.4862035</td></tr>\n",
       "\t<tr><th scope=row>deck3</th><td> 0.3154391</td><td> 1.0215659</td></tr>\n",
       "\t<tr><th scope=row>deck4</th><td> 0.3351347</td><td> 1.0355420</td></tr>\n",
       "\t<tr><th scope=row>deck5</th><td>-0.4919621</td><td> 0.2460091</td></tr>\n",
       "\t<tr><th scope=row>deck6</th><td>-0.8116090</td><td>-0.1318517</td></tr>\n",
       "\t<tr><th scope=row>deck7</th><td>-0.3626062</td><td> 0.2559195</td></tr>\n",
       "\t<tr><th scope=row>deck8</th><td>-0.8654282</td><td>-0.2326502</td></tr>\n",
       "\t<tr><th scope=row>deck9</th><td>-3.2462512</td><td> 1.8491741</td></tr>\n",
       "\t<tr><th scope=row>side2</th><td> 0.3835314</td><td> 0.6000041</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A matrix: 10 × 2 of type dbl\n",
       "\\begin{tabular}{r|ll}\n",
       "  & 2.5 \\% & 97.5 \\%\\\\\n",
       "\\hline\n",
       "\t(Intercept) & -1.1751032 & -0.5688343\\\\\n",
       "\tCryoSleep1 &  2.2204081 &  2.4862035\\\\\n",
       "\tdeck3 &  0.3154391 &  1.0215659\\\\\n",
       "\tdeck4 &  0.3351347 &  1.0355420\\\\\n",
       "\tdeck5 & -0.4919621 &  0.2460091\\\\\n",
       "\tdeck6 & -0.8116090 & -0.1318517\\\\\n",
       "\tdeck7 & -0.3626062 &  0.2559195\\\\\n",
       "\tdeck8 & -0.8654282 & -0.2326502\\\\\n",
       "\tdeck9 & -3.2462512 &  1.8491741\\\\\n",
       "\tside2 &  0.3835314 &  0.6000041\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A matrix: 10 × 2 of type dbl\n",
       "\n",
       "| <!--/--> | 2.5 % | 97.5 % |\n",
       "|---|---|---|\n",
       "| (Intercept) | -1.1751032 | -0.5688343 |\n",
       "| CryoSleep1 |  2.2204081 |  2.4862035 |\n",
       "| deck3 |  0.3154391 |  1.0215659 |\n",
       "| deck4 |  0.3351347 |  1.0355420 |\n",
       "| deck5 | -0.4919621 |  0.2460091 |\n",
       "| deck6 | -0.8116090 | -0.1318517 |\n",
       "| deck7 | -0.3626062 |  0.2559195 |\n",
       "| deck8 | -0.8654282 | -0.2326502 |\n",
       "| deck9 | -3.2462512 |  1.8491741 |\n",
       "| side2 |  0.3835314 |  0.6000041 |\n",
       "\n"
      ],
      "text/plain": [
       "            2.5 %      97.5 %    \n",
       "(Intercept) -1.1751032 -0.5688343\n",
       "CryoSleep1   2.2204081  2.4862035\n",
       "deck3        0.3154391  1.0215659\n",
       "deck4        0.3351347  1.0355420\n",
       "deck5       -0.4919621  0.2460091\n",
       "deck6       -0.8116090 -0.1318517\n",
       "deck7       -0.3626062  0.2559195\n",
       "deck8       -0.8654282 -0.2326502\n",
       "deck9       -3.2462512  1.8491741\n",
       "side2        0.3835314  0.6000041"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "## CIs using profiled log-likelihood\n",
    "confint(mylogit)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 17,
   "id": "f06ba169",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-12-19T20:12:11.834392Z",
     "iopub.status.busy": "2022-12-19T20:12:11.832736Z",
     "iopub.status.idle": "2022-12-19T20:12:11.864943Z",
     "shell.execute_reply": "2022-12-19T20:12:11.862016Z"
    },
    "papermill": {
     "duration": 0.046106,
     "end_time": "2022-12-19T20:12:11.867253",
     "exception": false,
     "start_time": "2022-12-19T20:12:11.821147",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A matrix: 10 × 2 of type dbl</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>2.5 %</th><th scope=col>97.5 %</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>(Intercept)</th><td>-1.1726451</td><td>-0.5670133</td></tr>\n",
       "\t<tr><th scope=row>CryoSleep1</th><td> 2.2192739</td><td> 2.4850189</td></tr>\n",
       "\t<tr><th scope=row>deck3</th><td> 0.3140336</td><td> 1.0197306</td></tr>\n",
       "\t<tr><th scope=row>deck4</th><td> 0.3337446</td><td> 1.0337102</td></tr>\n",
       "\t<tr><th scope=row>deck5</th><td>-0.4923628</td><td> 0.2451595</td></tr>\n",
       "\t<tr><th scope=row>deck6</th><td>-0.8124083</td><td>-0.1331346</td></tr>\n",
       "\t<tr><th scope=row>deck7</th><td>-0.3640283</td><td> 0.2539061</td></tr>\n",
       "\t<tr><th scope=row>deck8</th><td>-0.8663133</td><td>-0.2340491</td></tr>\n",
       "\t<tr><th scope=row>deck9</th><td>-2.5121214</td><td> 2.0545552</td></tr>\n",
       "\t<tr><th scope=row>side2</th><td> 0.3833690</td><td> 0.5998200</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A matrix: 10 × 2 of type dbl\n",
       "\\begin{tabular}{r|ll}\n",
       "  & 2.5 \\% & 97.5 \\%\\\\\n",
       "\\hline\n",
       "\t(Intercept) & -1.1726451 & -0.5670133\\\\\n",
       "\tCryoSleep1 &  2.2192739 &  2.4850189\\\\\n",
       "\tdeck3 &  0.3140336 &  1.0197306\\\\\n",
       "\tdeck4 &  0.3337446 &  1.0337102\\\\\n",
       "\tdeck5 & -0.4923628 &  0.2451595\\\\\n",
       "\tdeck6 & -0.8124083 & -0.1331346\\\\\n",
       "\tdeck7 & -0.3640283 &  0.2539061\\\\\n",
       "\tdeck8 & -0.8663133 & -0.2340491\\\\\n",
       "\tdeck9 & -2.5121214 &  2.0545552\\\\\n",
       "\tside2 &  0.3833690 &  0.5998200\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A matrix: 10 × 2 of type dbl\n",
       "\n",
       "| <!--/--> | 2.5 % | 97.5 % |\n",
       "|---|---|---|\n",
       "| (Intercept) | -1.1726451 | -0.5670133 |\n",
       "| CryoSleep1 |  2.2192739 |  2.4850189 |\n",
       "| deck3 |  0.3140336 |  1.0197306 |\n",
       "| deck4 |  0.3337446 |  1.0337102 |\n",
       "| deck5 | -0.4923628 |  0.2451595 |\n",
       "| deck6 | -0.8124083 | -0.1331346 |\n",
       "| deck7 | -0.3640283 |  0.2539061 |\n",
       "| deck8 | -0.8663133 | -0.2340491 |\n",
       "| deck9 | -2.5121214 |  2.0545552 |\n",
       "| side2 |  0.3833690 |  0.5998200 |\n",
       "\n"
      ],
      "text/plain": [
       "            2.5 %      97.5 %    \n",
       "(Intercept) -1.1726451 -0.5670133\n",
       "CryoSleep1   2.2192739  2.4850189\n",
       "deck3        0.3140336  1.0197306\n",
       "deck4        0.3337446  1.0337102\n",
       "deck5       -0.4923628  0.2451595\n",
       "deck6       -0.8124083 -0.1331346\n",
       "deck7       -0.3640283  0.2539061\n",
       "deck8       -0.8663133 -0.2340491\n",
       "deck9       -2.5121214  2.0545552\n",
       "side2        0.3833690  0.5998200"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "confint.default(mylogit)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 18,
   "id": "af1d5764",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-12-19T20:12:11.890662Z",
     "iopub.status.busy": "2022-12-19T20:12:11.889055Z",
     "iopub.status.idle": "2022-12-19T20:12:11.912810Z",
     "shell.execute_reply": "2022-12-19T20:12:11.911380Z"
    },
    "papermill": {
     "duration": 0.037647,
     "end_time": "2022-12-19T20:12:11.915075",
     "exception": false,
     "start_time": "2022-12-19T20:12:11.877428",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "Wald test:\n",
       "----------\n",
       "\n",
       "Chi-squared test:\n",
       "X2 = 213.5, df = 7, P(> X2) = 0.0"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "wald.test(b = coef(mylogit), Sigma = vcov(mylogit), Terms = 3:9)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 19,
   "id": "5ce33e7a",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-12-19T20:12:11.934389Z",
     "iopub.status.busy": "2022-12-19T20:12:11.932962Z",
     "iopub.status.idle": "2022-12-19T20:12:11.949881Z",
     "shell.execute_reply": "2022-12-19T20:12:11.948021Z"
    },
    "papermill": {
     "duration": 0.028895,
     "end_time": "2022-12-19T20:12:11.952066",
     "exception": false,
     "start_time": "2022-12-19T20:12:11.923171",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".dl-inline {width: auto; margin:0; padding: 0}\n",
       ".dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}\n",
       ".dl-inline>dt::after {content: \":\\0020\"; padding-right: .5ex}\n",
       ".dl-inline>dt:not(:first-of-type) {padding-left: .5ex}\n",
       "</style><dl class=dl-inline><dt>(Intercept)</dt><dd>0.419023101555092</dd><dt>CryoSleep1</dt><dd>10.5081001799131</dd><dt>deck3</dt><dd>1.94815372541054</dd><dt>deck4</dt><dd>1.98124890374465</dd><dt>deck5</dt><dd>0.883731794804078</dd><dt>deck6</dt><dd>0.623272507532425</dd><dt>deck7</dt><dd>0.946427357501719</dd><dt>deck8</dt><dd>0.576845264341827</dd><dt>deck9</dt><dd>0.795501088358237</dd><dt>side2</dt><dd>1.63492095986186</dd></dl>\n"
      ],
      "text/latex": [
       "\\begin{description*}\n",
       "\\item[(Intercept)] 0.419023101555092\n",
       "\\item[CryoSleep1] 10.5081001799131\n",
       "\\item[deck3] 1.94815372541054\n",
       "\\item[deck4] 1.98124890374465\n",
       "\\item[deck5] 0.883731794804078\n",
       "\\item[deck6] 0.623272507532425\n",
       "\\item[deck7] 0.946427357501719\n",
       "\\item[deck8] 0.576845264341827\n",
       "\\item[deck9] 0.795501088358237\n",
       "\\item[side2] 1.63492095986186\n",
       "\\end{description*}\n"
      ],
      "text/markdown": [
       "(Intercept)\n",
       ":   0.419023101555092CryoSleep1\n",
       ":   10.5081001799131deck3\n",
       ":   1.94815372541054deck4\n",
       ":   1.98124890374465deck5\n",
       ":   0.883731794804078deck6\n",
       ":   0.623272507532425deck7\n",
       ":   0.946427357501719deck8\n",
       ":   0.576845264341827deck9\n",
       ":   0.795501088358237side2\n",
       ":   1.63492095986186\n",
       "\n"
      ],
      "text/plain": [
       "(Intercept)  CryoSleep1       deck3       deck4       deck5       deck6 \n",
       "  0.4190231  10.5081002   1.9481537   1.9812489   0.8837318   0.6232725 \n",
       "      deck7       deck8       deck9       side2 \n",
       "  0.9464274   0.5768453   0.7955011   1.6349210 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "## odds ratios only\n",
    "exp(coef(mylogit))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 20,
   "id": "d22b49c7",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-12-19T20:12:11.972153Z",
     "iopub.status.busy": "2022-12-19T20:12:11.970742Z",
     "iopub.status.idle": "2022-12-19T20:12:13.327435Z",
     "shell.execute_reply": "2022-12-19T20:12:13.324322Z"
    },
    "papermill": {
     "duration": 1.368983,
     "end_time": "2022-12-19T20:12:13.329952",
     "exception": false,
     "start_time": "2022-12-19T20:12:11.960969",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Waiting for profiling to be done...\n",
      "\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A matrix: 10 × 3 of type dbl</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>OR</th><th scope=col>2.5 %</th><th scope=col>97.5 %</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>(Intercept)</th><td> 0.4190231</td><td>0.30878711</td><td> 0.5661851</td></tr>\n",
       "\t<tr><th scope=row>CryoSleep1</th><td>10.5081002</td><td>9.21108904</td><td>12.0155726</td></tr>\n",
       "\t<tr><th scope=row>deck3</th><td> 1.9481537</td><td>1.37086106</td><td> 2.7775406</td></tr>\n",
       "\t<tr><th scope=row>deck4</th><td> 1.9812489</td><td>1.39812871</td><td> 2.8166325</td></tr>\n",
       "\t<tr><th scope=row>deck5</th><td> 0.8837318</td><td>0.61142551</td><td> 1.2789112</td></tr>\n",
       "\t<tr><th scope=row>deck6</th><td> 0.6232725</td><td>0.44414286</td><td> 0.8764710</td></tr>\n",
       "\t<tr><th scope=row>deck7</th><td> 0.9464274</td><td>0.69586040</td><td> 1.2916487</td></tr>\n",
       "\t<tr><th scope=row>deck8</th><td> 0.5768453</td><td>0.42087129</td><td> 0.7924307</td></tr>\n",
       "\t<tr><th scope=row>deck9</th><td> 0.7955011</td><td>0.03891984</td><td> 6.3545691</td></tr>\n",
       "\t<tr><th scope=row>side2</th><td> 1.6349210</td><td>1.46745768</td><td> 1.8221263</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A matrix: 10 × 3 of type dbl\n",
       "\\begin{tabular}{r|lll}\n",
       "  & OR & 2.5 \\% & 97.5 \\%\\\\\n",
       "\\hline\n",
       "\t(Intercept) &  0.4190231 & 0.30878711 &  0.5661851\\\\\n",
       "\tCryoSleep1 & 10.5081002 & 9.21108904 & 12.0155726\\\\\n",
       "\tdeck3 &  1.9481537 & 1.37086106 &  2.7775406\\\\\n",
       "\tdeck4 &  1.9812489 & 1.39812871 &  2.8166325\\\\\n",
       "\tdeck5 &  0.8837318 & 0.61142551 &  1.2789112\\\\\n",
       "\tdeck6 &  0.6232725 & 0.44414286 &  0.8764710\\\\\n",
       "\tdeck7 &  0.9464274 & 0.69586040 &  1.2916487\\\\\n",
       "\tdeck8 &  0.5768453 & 0.42087129 &  0.7924307\\\\\n",
       "\tdeck9 &  0.7955011 & 0.03891984 &  6.3545691\\\\\n",
       "\tside2 &  1.6349210 & 1.46745768 &  1.8221263\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A matrix: 10 × 3 of type dbl\n",
       "\n",
       "| <!--/--> | OR | 2.5 % | 97.5 % |\n",
       "|---|---|---|---|\n",
       "| (Intercept) |  0.4190231 | 0.30878711 |  0.5661851 |\n",
       "| CryoSleep1 | 10.5081002 | 9.21108904 | 12.0155726 |\n",
       "| deck3 |  1.9481537 | 1.37086106 |  2.7775406 |\n",
       "| deck4 |  1.9812489 | 1.39812871 |  2.8166325 |\n",
       "| deck5 |  0.8837318 | 0.61142551 |  1.2789112 |\n",
       "| deck6 |  0.6232725 | 0.44414286 |  0.8764710 |\n",
       "| deck7 |  0.9464274 | 0.69586040 |  1.2916487 |\n",
       "| deck8 |  0.5768453 | 0.42087129 |  0.7924307 |\n",
       "| deck9 |  0.7955011 | 0.03891984 |  6.3545691 |\n",
       "| side2 |  1.6349210 | 1.46745768 |  1.8221263 |\n",
       "\n"
      ],
      "text/plain": [
       "            OR         2.5 %      97.5 %    \n",
       "(Intercept)  0.4190231 0.30878711  0.5661851\n",
       "CryoSleep1  10.5081002 9.21108904 12.0155726\n",
       "deck3        1.9481537 1.37086106  2.7775406\n",
       "deck4        1.9812489 1.39812871  2.8166325\n",
       "deck5        0.8837318 0.61142551  1.2789112\n",
       "deck6        0.6232725 0.44414286  0.8764710\n",
       "deck7        0.9464274 0.69586040  1.2916487\n",
       "deck8        0.5768453 0.42087129  0.7924307\n",
       "deck9        0.7955011 0.03891984  6.3545691\n",
       "side2        1.6349210 1.46745768  1.8221263"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "## odds ratios and 95% CI\n",
    "exp(cbind(OR = coef(mylogit), confint(mylogit)))"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "R",
   "language": "R",
   "name": "ir"
  },
  "language_info": {
   "codemirror_mode": "r",
   "file_extension": ".r",
   "mimetype": "text/x-r-source",
   "name": "R",
   "pygments_lexer": "r",
   "version": "4.0.5"
  },
  "papermill": {
   "default_parameters": {},
   "duration": 8.691026,
   "end_time": "2022-12-19T20:12:13.466661",
   "environment_variables": {},
   "exception": null,
   "input_path": "__notebook__.ipynb",
   "output_path": "__notebook__.ipynb",
   "parameters": {},
   "start_time": "2022-12-19T20:12:04.775635",
   "version": "2.4.0"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
