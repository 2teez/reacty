function BookList() {
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
        <tr>
          <td>JavaScript-The Comprehensive Guide</td>
          <td>Philip Ackermann</td>
          <td>978-3836286299</td>
          <td>*****</td>
        </tr>
        <tr>
          <td>Clean Code</td>
          <td>Robert Martin</td>
          <td>978-0132350884</td>
          <td>****</td>
        </tr>
        <tr>
          <td>Design Patterns</td>
          <td>Erich Gamma</td>
          <td>978-0201633610</td>
          <td>*****</td>
        </tr>
      </tbody>
    </table>
  );
}

export default BookList;
