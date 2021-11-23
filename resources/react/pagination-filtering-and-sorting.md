---
layout: single
classes: wide
title:  "React - Pagination, Filtering and Sorting"
date:   2021-11-15 10:00:50 +0800
categories: react
allow_different_nesting: true
toc: true
toc_label: "In this page"
toc_icon: " "
toc_sticky: true
sidebar:
  nav: "react"
---

## Pagination, Filtering and Sorting

### Purpose

* component
* cleaner code
* refactoring

### 1,2,3,4 - Pagination Components

* install lodash
  * npm i lodash@4.17.10
* goto [bootstrap pagination](https://getbootstrap.com/docs/4.0/components/pagination/) to get the html
* create src/components/common/pagination.jsx
* import and create pagination component in movies.jsx
* move getMovies and getGenre to componentDidMount

```jsx
import Pagination from "./common/pagination";
...
  state = {
    movies: {}
    pageSize: 4,
  };

  componentDidMount() {
    this.setState({ movies: getMovies(), genres: getGenres() });
  }
  ...
          <Pagination
            itemCount={this.state.movies.length}
            itemPerPage={this.state.pageSize}
            handlePageChange={this.handlePageChange}
          />
```

* pagination.jsx

```js
import React, { Component } from "react";
import lodash from "lodash";
class Pagination extends Component {
  render() {
    const { itemCount, itemPerPage } = this.props;
    let numberOfPages = Math.ceil(itemCount / itemPerPage);
    let pages = lodash.range(1, numberOfPages + 1);
    if (numberOfPages == 1) return null; // don't render pagination if only 1 page

    return (
      <nav aria-label="Page navigation example"> // modify this from bootstrap pagination
        <ul className="pagination">
          {pages.map((page) => (
            <li key={page} className="page-item">
              <a
                className="page-link"
                onClick={() => this.props.handlePageChange(page)}
              >
                {page}
              </a>
            </li>
          ))}
        </ul>
      </nav>
    );
  }
}
export default Pagination;
```

### 5 - handling page changes

* pagination.jsx
  * highlight when current page
  * click to call movies.handlePageChanged

```js
<li
  key={page}
  className={page == this.props.currentPage ? "page-item active" : "page-item"}
>
  <a
    className="page-link"
    onClick={() => this.props.handlePageChange(page)}
  >
    {page}
  </a>
</li>
```

* movies.jsx
  * implement handlePageChanged method
    * store currentPage into state
    * pass currentPage to pagination

```js
  state = {
    ...
    currentPage: 1,
  };
  ...
  handlePageChange = (page) => {
    this.setState({ currentPage: page });
  };
  ...
          <Pagination
            ...
            handlePageChange={this.handlePageChange}
          />
```

### 6 - Pagination - Paginating Data

* create src/utils/paginate.js
  * common function to handle pagination
    * use lodash

```js
import _ from "lodash";

export function paginate(items, pageNumber, pageSize) {
  const startIndex = (pageNumber - 1) * pageSize;
  return _(items).slice(startIndex).take(pageSize).value();
}
```

* edit movies.jsx
  * import and call paginate
  * change reference from this.state.movie to movie

```js
...
import { paginate } from "../utils/paginate";
...
  render() {
    const movies = paginate(
      this.state.movies,
      this.state.currentPage,
      this.state.pageSize
    );
    ...
    <Summary count={movies.length} />
    ...
              {movies.map((m) => (
                <Movie
```

### 7 - Pagination - type checking with proptypes (optional)

* npm i prop-types@15.6.2
* edit paginatation.jsx
  * import PropTypes
  * declare PropTypes for member

```js
import PropTypes from "prop-types";
...
Pagination.propTypes = {
  itemCount: PropTypes.number.isRequired,
  itemPerPage: PropTypes.number.isRequired,
  currentPage: PropTypes.number.isRequired,
  handlePageChange: PropTypes.func.isRequired,
};
```

### 8,9,12,13,14 - Exercise - ListGroup Component and Interface/handling selection/implement filtering/adding All genres

* create Filter.jsx
  * use bootstrap listgroup html snippet
  * make sure component can be reused
    * change item._id to item[this.state.keyProperty] (where keyProperty="_id" which is configrable by caller)
  * add "all" option
  * call handleFilterItems when clicked
    * paginate the filtered items
    * refresh the UI

```js
import React, { Component } from "react";
class Filter extends React.Component {
  getItems() {
    return this.props.items.map((item) => (
      <li
        key={item[this.props.keyProperty]}
        onClick={() => this.props.handleFilterItems(item)}
        className={
          item[this.props.keyProperty] ===
          this.props.selectedItem[this.props.keyProperty]
            ? "list-group-item active"
            : "list-group-item"
        }
        style=\{\{ cursor: "pointer" }}
      >
        {item[this.props.nameProperty]}
      </li>
    ));
  }

  render() {
    return <ul className="list-group">{this.getItems()}</ul>;
  }
}
export default Filter;
```

* movies.jsx
  * import filter.jsx
  * initializes state
  * filter before paginate or return all if crrentFilter=all
  * include Filter component and pass in parameters and controls

```js
import Filter from "./common/filter";
...
  state = {
    ...
    currentFilter: "all",
  };
  ...
  componentDidMount() {
    this.setState({
      movies: getMovies(),
      genres: [{ name: "All Genres" }, ...getGenres()],
    });
  }
  ...
  render() {
    const allMovies = [...this.state.movies];
    const filteredMovies =
      this.state.selectedGenre && this.state.selectedGenre._id == undefined // all
        ? allMovies
        : allMovies.filter((m) => m.genre._id === this.state.selectedGenre._id);
    const paginatedMovies = paginate(
      filteredMovies,
      this.state.currentPage,
      this.state.pageSize
    );
    ...
          <Filter
            currentFilter={this.state.currentFilter}
            items={getGenres()}
            keyProperty="_id"
            nameProperty="name"
            handleFilterItems={this.handleFilterItems}
          />
```

### 10,11 - Filtering - Displaying Items/Default Props

* keyProperty and nameProperty in filter.jsx can be configure to accept default value
  * If caller do not passed in value, default value will be used
* filter.js

```js
Filter.defaultProps = {
  keyProperty: "_id",
  nameProperty: "name",
};
```

* movies.jsx

```js
            items={getGenres()}
            keyProperty="_id" // remove this line
            nameProperty="name" // remove this line
            handleFilterItems={this.handleFilterItems}
```

### 15,16 - extracting moviestables/raising the sort event

* create src/component/MovieTable.jsx and move all <table> related code inside
  * import into movies.jsx  and use it
* movietable.jsx

```js
import React, { Component } from "react";
import Movie from "./movie";

class MovieTable extends React.Component {
  render() {
    const { movies, handleDelete, handleLiked } = this.props;

    return (
      <table className="table">
        <thead>
          <tr>
            <th>Title</th>
            <th>Genre</th>
            <th>Stock</th>
            <th>Rate</th>
            <th>Liked?</th>
            <th>Delete</th>
          </tr>
          {movies.map((m) => (
            <Movie
              key={m._id}
              movie={m}
              handleDelete={handleDelete}
              handleLiked={handleLiked}
            />
          ))}
        </thead>
      </table>
    );
  }
}

export default MovieTable;

```

* movie.jsx

```js
          <MovieTable
            movies={paginatedMovies}
            handleLiked={this.handleLiked}
            handleDelete={this.handleDelete}
          />
```

### 17,18 - implemting soirting/moving responsibility

* sort the filtered - all columns + asc/desc
* movietable.jsx

```js
  handleSort = (columnName) => {
    const sortOrder = this.props.sortState.sortOrder === "asc" ? "desc" : "asc";
    this.props.handleSort({ columnName, sortOrder });
  };
...
  render() {
    ...
            <th onClick={() => this.handleSort("title")}>Title</th>
            <th onClick={() => this.handleSort("genre.name")}>Genre</th>
            <th onClick={() => this.handleSort("numberInStock")}>Stock</th>
            <th onClick={() => this.handleSort("dailyRentalRate")}>Rate</th>
```

* movies.jsx

```js
  ...
  state = {
    ...
    selectedGenre: { _id: "all", name: "All Genres" },
    sortState: { columnName: "title", sortOrder: "asc" },
  };

  componentDidMount() {
    this.setState({
      ...
      genres: [{ _id: "all", name: "All Genres" }, ...getGenres()],
    });
  }
  ...
  handleSort = (sortState) => {
    this.setState({
      sortState,
    });
  };
  ...
  render() {
    ...
    const filteredMovies =
      this.state.selectedGenre && this.state.selectedGenre._id === "all"
        ? allMovies
        : allMovies.filter((m) => m.genre._id === this.state.selectedGenre._id);

    const sortedMovies = _.orderBy(
      filteredMovies,
      [this.state.sortState.columnName],
      [this.state.sortState.sortOrder]
    );

    const paginatedMovies = paginate(
      sortedMovies,
      ...
    );
    ...
          <MovieTable
            ...
            handleSort={this.handleSort}
          />
```

### 19 - extracting tableheader

* create tableHeader.jsx
  * input parameter
    * columns = [{key,path,label},...]
    * sortState = {columnName, sortOrder}
    * handleSort = f

```js
import React, { Component } from "react";

// columns = [{key,path,label},...]
// sortState = {columnName, sortOrder}
// handleSort = f
class TableHeader extends React.Component {
  handleSort = (columnName) => {
    const sortOrder = this.props.sortState.sortOrder === "asc" ? "desc" : "asc";
    this.props.handleSort({ columnName, sortOrder });
  };

  render() {
    return this.props.columns.map((c) => (
      <th
        style=\{\{ cursor: "pointer" }}
        key={c.key}
        onClick={() => this.handleSort(c.path)}
      >
        {c.label}
      </th>
    ));
  }
}

export default TableHeader;
```

* movietable.jsx
  * import and create table header
  * create columns array and pass to tableheader
  * pass sortState
  * pass handleSort

```js
    let columns = [
      { key: 1, path: "title", label: "Title" },
      { key: 2, path: "genre.name", label: "Genre" },
      { key: 3, path: "numberInStock", label: "Stock" },
      { key: 4, path: "dailyRentalRate", label: "Rate" },
      { key: 5, label: "Liked" },
      { key: 6, label: "Delete" },
    ];
    ...
    render() {
      ...
                  <TableHeader
              handleSort={this.props.handleSort}
              sortState={this.props.sortState}
              columns={columns}
            />
            ...
    }
```

### 20, 21, 22 - extracting tablebody, extracting cell content

* movietable.jsx

```jsx
...
    let columns = [
      { key: 1, path: "title", label: "Title" },
      { key: 2, path: "genre.name", label: "Genre" },
      { key: 3, path: "numberInStock", label: "Stock" },
      { key: 4, path: "dailyRentalRate", label: "Rate" },
      {
        key: 5,
        label: "Liked",
        content: (movie) => (
          <Like
            liked={movie.liked}
            handleLiked={this.props.handleLiked}
            item={movie}
          />
        ),
      },
      {
        key: 6,
        label: "Delete",
        content: (movie) => (
          <button
            className="btn btn-danger"
            onClick={() => this.props.handleDelete(movie)}
          >
            delete
          </button>
        ),
      },
    ];
    ...
    render() {
      ...
      <TableBody data={movies} columns={columns} />
      ...
    }
```

* common/tablebody.jsx

```jsx
import React from "react";
import _ from "lodash";
class TableBody extends React.Component {
  renderCell(item, column) {
    if (column.content) return column.content(item); // render like, delete or anything with content

    return _.get(item, column.path);
  }
  render() {
    const { data, columns } = this.props;

    return (
      <tbody>
        {data.map((item) => (
          <tr key={item["_id"]}>
            {columns.map((column) => (
              <td key={column.key}>{this.renderCell(item, column)}</td>
            ))}
          </tr>
        ))}
      </tbody>
    );
  }
}

export default TableBody;

```

### 23 - adding the sort icon

* index.css

```css
.clickable {
  cursor: "pointer"
}
```

* tableheader.jsx

```jsx
...
  renderSortIcon = (column) => {
    if (column.path !== this.props.sortState.columnName) return null;
    if (this.props.sortState.sortOrder === "asc")
      return <i className="fa fa-sort-asc"></i>;
    return <i className="fa fa-sort-desc"></i>;
  };
  ...
        <th
        style=\{\{ cursor: "pointer" }}
        key={c.key}
        onClick={() => this.handleSort(c.path)}
      >
        {c.label} {this.renderSortIcon(c)}
      </th>
      ...

```

### 24 - extracting table (as common components)

* create common/table.jsx

```jsx
import React from "react";
import TableHeader from "./tableheader";
import TableBody from "./tablebody";
class Table extends React.Component {
  render() {
    return (
      <table className="table">
        <thead>
          <tr>
            <TableHeader
              handleSort={this.props.handleSort}
              sortState={this.props.sortState}
              columns={this.props.columns}
            />
          </tr>
        </thead>
        <TableBody data={this.props.data} columns={this.props.columns} />
      </table>
    );
  }
}

export default Table;
```

* movieTables.jsx
  * import table.jsx and use

```jsx
  import Table from "./common/table";
  ...
    return (
      <Table
        handleSort={this.props.handleSort}
        sortState={this.props.sortState}
        columns={columns}
        data={this.props.movies}
      />
    );
    ...
```

### 25 - extracting method

* movies.jsx

```jsx
...
  getPaginateMovies = () => {
    const allMovies = [...this.state.movies];
    const filteredMovies =
      this.state.selectedGenre && this.state.selectedGenre._id === "all"
        ? allMovies
        : allMovies.filter((m) => m.genre._id === this.state.selectedGenre._id);

    const sortedMovies = _.orderBy(
      filteredMovies,
      [this.state.sortState.columnName],
      [this.state.sortState.sortOrder]
    );

    const paginatedMovies = paginate(
      sortedMovies,
      this.state.currentPage,
      this.state.pageSize
    );

    return { paginatedMovies, filteredMovies };
  };
...
  render() {
    var result = this.getPaginateMovies();
  ...
            count={result.paginatedMovies.length}
            itemFilteredCount={result.filteredMovies.length}
  ...
}
```