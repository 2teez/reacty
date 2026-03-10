 const Greet = ({ name }) => <hl>Hello {name}!</hl>;
    const rootElement = document.getElementById('root');
    const root = ReactDOM.createRoot(rootElement);
    root.render(<Greet name="Reader" />);
