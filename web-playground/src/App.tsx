import { useState } from "react";
import "./App.css";
import init, {
    topiaryInit,
    format,
} from "./wasm-app/topiary_playground.js";
import languages from './samples/languages_export';

function App() {
    const [isInitialised, setIsInitialised] = useState(false);
    const defaultLanguage = "json";
    const defaultQuery = languages[defaultLanguage].query;
    const defaultInput = languages[defaultLanguage].input;
    const [query, setQuery] = useState(defaultQuery);
    const [input, setInput] = useState(defaultInput);
    const [output, setOutput] = useState("");

    let languageItems = [];
    for (let l in languages) {
        languageItems.push(<option key={l} value={l}>{l}</option>)
    }

    async function runFormat() {
        try {
            if (!isInitialised) {
                await init();
                await topiaryInit();
                setIsInitialised(true);
            }

            setOutput("Formatting ...");
            setOutput(await format(input, query));
        } catch (e) {
            setOutput(String(e));
        }
    }

    function changeLanguage(l: string) {
        if (languages[l]) {
            setInput(languages[l].input);
            setQuery(languages[l].query);
        }
    }

    return (
        <div className="App">
            <div className="header">
                <select onChange={e => changeLanguage(e.target.value)}>
                    <option value="">Choose a reference language</option>
                    {languageItems}
                </select>
                <button id="formatButton" className="btn btn-primary" onClick={runFormat}>
                    Format
                </button>
            </div>
            <div className="columns">
                <div className="column">
                    <h1>Query</h1>
                    <textarea id="query" value={query} onChange={e => setQuery(e.target.value)} />
                </div>
                <div className="column">
                    <h1>Input</h1>
                    <textarea id="input" value={input} onChange={e => setInput(e.target.value)} />
                </div>
                <div className="column">
                    <h1>Output</h1>
                    <textarea id="output" value={output} readOnly></textarea>
                </div>
            </div>
        </div>
    );
}

export default App;
