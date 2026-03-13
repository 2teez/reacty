import "./BookList.css";

const books = [
  {
    id: 1,
    title: "The Catcher in the Rye",
    author: "J.D. Salinger",
    isbn: "9780316776954",
    rating: 4.2,
  },
  {
    id: 2,
    title: "To Kill a Mockingbird",
    author: "Harper Lee",
    isbn: "9780061120084",
    rating: 4.3,
  },
  {
    id: 3,
    title: "1984",
    author: "George Orwell",
    isbn: "9780451524935",
    rating: 4.4,
  },
];

function BookList() {
  if (books.length === 0) {
    return <div>No books available.</div>;
  } else {
    return (
      <table>
        <thead>
          <tr>
            <th>Title</th>
            <th>Author</th>
            <th>ISBN</th>
            <th>Rating</th>
          </tr>
        </thead>
        <tbody>
          {books.map((book) => (
            <tr key={book.id}>
              <td>{book.title}</td>
              <td>{book.author ? book.author : "Unknown"}</td>
              <td>{book.isbn}</td>
              <td>{book.rating && <span>{"*".repeat(book.rating)}</span>}</td>
            </tr>
          ))}
        </tbody>
      </table>
    );
  }
}

export default BookList;
