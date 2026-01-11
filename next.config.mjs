/** @type {import('next').NextConfig} */
const nextConfig = {
    images: {
        remotePatterns: [
            {
                protocol: 'http',
                hostname: '127.0.0.1',
                port: '8000',
                pathname: '/storage/**',
            },
            {
                protocol: 'http',
                hostname: 'localhost',
                port: '8000',
                pathname: '/storage/**',
            },
            {
                protocol: 'https',
                hostname: 'images.unsplash.com',
            },
            // Add your Render backend domain
            ...(process.env.NEXT_PUBLIC_BACKEND_URL
                ? [{
                    protocol: 'https',
                    hostname: new URL(process.env.NEXT_PUBLIC_BACKEND_URL).hostname,
                    pathname: '/storage/**',
                }]
                : []),
        ],
    },
    async headers() {
        return [
            {
                source: '/:path*',
                headers: [
                    {
                        key: 'X-DNS-Prefetch-Control',
                        value: 'on'
                    },
                    {
                        key: 'Strict-Transport-Security',
                        value: 'max-age=63072000; includeSubDomains; preload'
                    },
                    {
                        key: 'X-XSS-Protection',
                        value: '1; mode=block'
                    },
                    {
                        key: 'X-Frame-Options',
                        value: 'DENY'
                    },
                    {
                        key: 'X-Content-Type-Options',
                        value: 'nosniff'
                    },
                    {
                        key: 'Referrer-Policy',
                        value: 'strict-origin-when-cross-origin'
                    },
                    {
                        key: 'Permissions-Policy',
                        value: 'camera=(), microphone=(), geolocation=(), interest-cohort=()'
                    },
                    {
                        key: 'Content-Security-Policy',
                        value: `default-src 'self'; script-src 'self' 'unsafe-eval' 'unsafe-inline'; style-src 'self' 'unsafe-inline'; img-src 'self' blob: data: http://127.0.0.1:8000 http://localhost:8000 https://images.unsplash.com ${process.env.NEXT_PUBLIC_BACKEND_URL || ''}; font-src 'self' data:; connect-src 'self' http://127.0.0.1:8000 http://localhost:8000 ${process.env.NEXT_PUBLIC_BACKEND_URL || ''}; frame-ancestors 'none';`
                    }
                ],
            },
        ];
    },
};

export default nextConfig;
