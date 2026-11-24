import { ButtonHTMLAttributes, InputHTMLAttributes, ReactNode, useId } from 'react';

export function Button({ loading = false, children, disabled, className = '', ...props }: ButtonHTMLAttributes<HTMLButtonElement> & { loading?: boolean }) {
  return <button {...props} disabled={disabled || loading} className={`ui-button ${className}`}>{loading && <span className="ui-spinner" aria-hidden="true"/>}{loading ? 'Aguarde...' : children}</button>;
}

export function Input({ label, error, id, ...props }: InputHTMLAttributes<HTMLInputElement> & { label: string; error?: string }) {
  const generatedId = useId();
  const inputId = id || generatedId;
  const errorId = `${inputId}-error`;
  return <label className="ui-field" htmlFor={inputId}><span>{label}</span><input {...props} id={inputId} aria-invalid={Boolean(error)} aria-describedby={error ? errorId : undefined}/>{error && <small id={errorId} className="ui-error">{error}</small>}</label>;
}

export function Card({ children, className = '' }: { children: ReactNode; className?: string }) {
  return <section className={`ui-card ${className}`}>{children}</section>;
}

export function Badge({ children, tone = 'neutral' }: { children: ReactNode; tone?: 'neutral' | 'success' | 'warning' | 'danger' }) {
  return <span className={`ui-badge ${tone}`}>{children}</span>;
}
